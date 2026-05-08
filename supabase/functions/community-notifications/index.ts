import { createClient } from "https://esm.sh/@supabase/supabase-js@2.50.2";

type JsonRecord = Record<string, unknown>;

type DatabaseWebhookPayload = {
  type?: string;
  table?: string;
  schema?: string;
  record?: JsonRecord | null;
  old_record?: JsonRecord | null;
};

type NotificationType =
  | "new_post"
  | "new_story"
  | "post_comment"
  | "post_reaction"
  | "new_follower";

type NotificationInsert = {
  recipient_user_id: string;
  actor_user_id: string;
  actor_name: string;
  actor_avatar_url: string;
  notification_type: NotificationType;
  source_table: string;
  source_record_id: string;
  entity_type: "post" | "story" | "profile";
  entity_id: string;
  title: string;
  body: string;
  image_url: string;
  metadata: Record<string, unknown>;
};

type NotificationRow = NotificationInsert & {
  id: string;
};

type PushTokenRow = {
  id: string;
  user_id: string;
  token: string;
  platform: string;
};

const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
const webhookSecret = Deno.env.get("COMMUNITY_WEBHOOK_SECRET") ?? "";
const fcmProjectId = Deno.env.get("FCM_PROJECT_ID") ?? "";
const fcmClientEmail = Deno.env.get("FCM_CLIENT_EMAIL") ?? "";
const fcmPrivateKey = (Deno.env.get("FCM_PRIVATE_KEY") ?? "").replaceAll(
  String.raw`\n`,
  "\n",
);

if (!supabaseUrl || !serviceRoleKey) {
  throw new Error(
    "Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY environment variables.",
  );
}

const supabase = createClient(supabaseUrl, serviceRoleKey, {
  auth: { autoRefreshToken: false, persistSession: false },
});

Deno.serve(async (request) => {
  if (request.method !== "POST") {
    return jsonResponse(
      { error: "Method not allowed." },
      { status: 405 },
    );
  }

  if (webhookSecret) {
    const providedSecret = request.headers.get("x-webhook-secret") ?? "";
    if (providedSecret != webhookSecret) {
      return jsonResponse({ error: "Unauthorized." }, { status: 401 });
    }
  }

  const payload = (await request.json()) as DatabaseWebhookPayload;

  try {
    const result = await handleWebhook(payload);
    return jsonResponse({ success: true, ...result });
  } catch (error) {
    console.error("community-notifications failed", error);
    return jsonResponse(
      {
        error: error instanceof Error ? error.message : "Unexpected error.",
      },
      { status: 500 },
    );
  }
});

async function handleWebhook(payload: DatabaseWebhookPayload) {
  const table = payload.table ?? "";
  const eventType = (payload.type ?? "").toUpperCase();
  const record = payload.record;

  if (eventType !== "INSERT" || !table || !record) {
    return { skipped: true, reason: "Only insert webhooks are processed." };
  }

  switch (table) {
    case "community_posts":
      return await handleNewPost(record);
    case "community_stories":
      return await handleNewStory(record);
    case "community_comments":
      return await handleNewComment(record);
    case "community_reactions":
      return await handleNewReaction(record);
    case "community_follows":
      return await handleNewFollow(record);
    default:
      return { skipped: true, reason: `Unsupported table: ${table}` };
  }
}

async function handleNewPost(record: JsonRecord) {
  const actorUserId = readString(record, "user_id");
  const sourceRecordId = readString(record, "id");
  assertRequired(actorUserId, "community_posts.user_id");
  assertRequired(sourceRecordId, "community_posts.id");
  const actor = await resolveActor(record, actorUserId);
  const followers = await fetchFollowerIds(actorUserId);

  if (followers.length === 0) {
    return { inserted: 0, table: "community_posts" };
  }

  const title = `${actor.name} vừa đăng bài viết mới`;
  const body = buildPostSummary(record);
  const imageUrl = firstNonEmpty(
    readString(record, "movie_poster_url"),
    readString(record, "image_url"),
  );

  const rows = followers
      .filter((recipientUserId) => recipientUserId !== actorUserId)
      .map<NotificationInsert>((recipientUserId) => ({
        recipient_user_id: recipientUserId,
        actor_user_id: actorUserId,
        actor_name: actor.name,
        actor_avatar_url: actor.avatarUrl,
        notification_type: "new_post",
        source_table: "community_posts",
        source_record_id: sourceRecordId,
        entity_type: "post",
        entity_id: sourceRecordId,
        title,
        body,
        image_url: imageUrl,
        metadata: {
          post_id: sourceRecordId,
          movie_slug: readString(record, "movie_slug"),
          movie_title: readString(record, "movie_title"),
        },
      }));

  const insertedRows = await insertNotifications(rows);
  const pushResult = await sendPushNotifications(insertedRows);
  return {
    inserted: insertedRows.length,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
    table: "community_posts",
  };
}

async function handleNewStory(record: JsonRecord) {
  const actorUserId = readString(record, "user_id");
  const sourceRecordId = readString(record, "id");
  assertRequired(actorUserId, "community_stories.user_id");
  assertRequired(sourceRecordId, "community_stories.id");
  const actor = await resolveActor(record, actorUserId);
  const followers = await fetchFollowerIds(actorUserId);

  if (followers.length === 0) {
    return { inserted: 0, table: "community_stories" };
  }

  const title = `${actor.name} vừa đăng tin mới`;
  const body = buildStorySummary(record);
  const imageUrl = firstNonEmpty(
    readString(record, "movie_poster_url"),
    readString(record, "image_url"),
  );

  const rows = followers
      .filter((recipientUserId) => recipientUserId !== actorUserId)
      .map<NotificationInsert>((recipientUserId) => ({
        recipient_user_id: recipientUserId,
        actor_user_id: actorUserId,
        actor_name: actor.name,
        actor_avatar_url: actor.avatarUrl,
        notification_type: "new_story",
        source_table: "community_stories",
        source_record_id: sourceRecordId,
        entity_type: "story",
        entity_id: sourceRecordId,
        title,
        body,
        image_url: imageUrl,
        metadata: {
          story_id: sourceRecordId,
          movie_slug: readString(record, "movie_slug"),
          movie_title: readString(record, "movie_title"),
        },
      }));

  const insertedRows = await insertNotifications(rows);
  const pushResult = await sendPushNotifications(insertedRows);
  return {
    inserted: insertedRows.length,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
    table: "community_stories",
  };
}

async function handleNewComment(record: JsonRecord) {
  const actorUserId = readString(record, "user_id");
  const sourceRecordId = readString(record, "id");
  const postId = readString(record, "post_id");
  assertRequired(actorUserId, "community_comments.user_id");
  assertRequired(sourceRecordId, "community_comments.id");
  assertRequired(postId, "community_comments.post_id");
  const actor = await resolveActor(record, actorUserId);
  const post = await fetchPost(postId);

  if (!post || post.user_id === actorUserId) {
    return { inserted: 0, table: "community_comments" };
  }

  const row: NotificationInsert = {
    recipient_user_id: post.user_id,
    actor_user_id: actorUserId,
    actor_name: actor.name,
    actor_avatar_url: actor.avatarUrl,
    notification_type: "post_comment",
    source_table: "community_comments",
    source_record_id: sourceRecordId,
    entity_type: "post",
    entity_id: postId,
    title: `${actor.name} đã bình luận bài viết của bạn`,
    body: buildCommentSummary(record),
    image_url: firstNonEmpty(post.movie_poster_url, post.image_url),
    metadata: {
      post_id: postId,
      comment_id: sourceRecordId,
      movie_slug: post.movie_slug,
      movie_title: post.movie_title,
    },
  };

  const insertedRows = await insertNotifications([row]);
  const pushResult = await sendPushNotifications(insertedRows);
  return {
    inserted: insertedRows.length,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
    table: "community_comments",
  };
}

async function handleNewReaction(record: JsonRecord) {
  const actorUserId = readString(record, "user_id");
  const sourceRecordId = readString(record, "id");
  const postId = readString(record, "post_id");
  assertRequired(actorUserId, "community_reactions.user_id");
  assertRequired(sourceRecordId, "community_reactions.id");
  assertRequired(postId, "community_reactions.post_id");
  const actor = await resolveActor(record, actorUserId);
  const post = await fetchPost(postId);

  if (!post || post.user_id === actorUserId) {
    return { inserted: 0, table: "community_reactions" };
  }

  const reactionType = readString(record, "reaction_type") || "like";
  const row: NotificationInsert = {
    recipient_user_id: post.user_id,
    actor_user_id: actorUserId,
    actor_name: actor.name,
    actor_avatar_url: actor.avatarUrl,
    notification_type: "post_reaction",
    source_table: "community_reactions",
    source_record_id: sourceRecordId,
    entity_type: "post",
    entity_id: postId,
    title: `${actor.name} đã thả cảm xúc vào bài viết của bạn`,
    body: reactionType,
    image_url: firstNonEmpty(post.movie_poster_url, post.image_url),
    metadata: {
      post_id: postId,
      reaction_id: sourceRecordId,
      reaction_type: reactionType,
      movie_slug: post.movie_slug,
      movie_title: post.movie_title,
    },
  };

  const insertedRows = await insertNotifications([row]);
  const pushResult = await sendPushNotifications(insertedRows);
  return {
    inserted: insertedRows.length,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
    table: "community_reactions",
  };
}

async function handleNewFollow(record: JsonRecord) {
  const actorUserId = readString(record, "follower_id");
  const recipientUserId = readString(record, "following_id");
  const sourceRecordId = readString(record, "id");
  assertRequired(actorUserId, "community_follows.follower_id");
  assertRequired(recipientUserId, "community_follows.following_id");
  assertRequired(sourceRecordId, "community_follows.id");

  if (actorUserId === recipientUserId) {
    return { inserted: 0, table: "community_follows" };
  }

  const actor = await resolveActor(record, actorUserId);
  const row: NotificationInsert = {
    recipient_user_id: recipientUserId,
    actor_user_id: actorUserId,
    actor_name: actor.name,
    actor_avatar_url: actor.avatarUrl,
    notification_type: "new_follower",
    source_table: "community_follows",
    source_record_id: sourceRecordId,
    entity_type: "profile",
    entity_id: actorUserId,
    title: `${actor.name} đã follow bạn`,
    body: "Chạm để xem hồ sơ của người này.",
    image_url: actor.avatarUrl,
    metadata: {
      follower_user_id: actorUserId,
      following_user_id: recipientUserId,
    },
  };

  const insertedRows = await insertNotifications([row]);
  const pushResult = await sendPushNotifications(insertedRows);
  return {
    inserted: insertedRows.length,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
    table: "community_follows",
  };
}

async function fetchFollowerIds(userId: string): Promise<string[]> {
  const { data, error } = await supabase
    .from("community_follows")
    .select("follower_id")
    .eq("following_id", userId);

  if (error) {
    throw error;
  }

  return (data ?? [])
    .map((row) => String(row.follower_id ?? "").trim())
    .filter(Boolean);
}

async function fetchPost(postId: string) {
  const { data, error } = await supabase
    .from("community_posts")
    .select("id, user_id, movie_slug, movie_title, movie_poster_url, image_url")
    .eq("id", postId)
    .maybeSingle();

  if (error) {
    throw error;
  }

  return data
    ? {
        id: String(data.id),
        user_id: String(data.user_id),
        movie_slug: String(data.movie_slug ?? ""),
        movie_title: String(data.movie_title ?? ""),
        movie_poster_url: String(data.movie_poster_url ?? ""),
        image_url: String(data.image_url ?? ""),
      }
    : null;
}

async function resolveActor(record: JsonRecord, userId: string) {
  const directName = firstNonEmpty(
    readString(record, "author_name"),
    readString(record, "full_name"),
  );
  const directAvatarUrl = readString(record, "author_avatar_url");
  if (directName || directAvatarUrl) {
    return {
      name: firstNonEmpty(directName, "iMovie user"),
      avatarUrl: directAvatarUrl,
    };
  }

  const { data, error } = await supabase
    .from("profiles")
    .select("full_name, avatar_url")
    .eq("id", userId)
    .maybeSingle();

  if (error) {
    throw error;
  }

  return {
    name: firstNonEmpty(String(data?.full_name ?? ""), "iMovie user"),
    avatarUrl: String(data?.avatar_url ?? "").trim(),
  };
}

async function insertNotifications(rows: NotificationInsert[]) {
  if (rows.length === 0) {
    return [] as NotificationRow[];
  }

  const insertedRows: NotificationRow[] = [];
  for (const chunk of chunked(rows, 500)) {
    const { data, error } = await supabase
      .from("community_notifications")
      .upsert(chunk, {
        onConflict: "recipient_user_id,source_table,source_record_id",
        ignoreDuplicates: false,
      })
      .select(`
        id,
        recipient_user_id,
        actor_user_id,
        actor_name,
        actor_avatar_url,
        notification_type,
        source_table,
        source_record_id,
        entity_type,
        entity_id,
        title,
        body,
        image_url,
        metadata
      `);

    if (error) {
      throw error;
    }

    for (const row of data ?? []) {
      insertedRows.push({
        id: String(row.id),
        recipient_user_id: String(row.recipient_user_id),
        actor_user_id: String(row.actor_user_id),
        actor_name: String(row.actor_name ?? ""),
        actor_avatar_url: String(row.actor_avatar_url ?? ""),
        notification_type: row.notification_type as NotificationType,
        source_table: String(row.source_table),
        source_record_id: String(row.source_record_id),
        entity_type: row.entity_type as "post" | "story" | "profile",
        entity_id: String(row.entity_id),
        title: String(row.title ?? ""),
        body: String(row.body ?? ""),
        image_url: String(row.image_url ?? ""),
        metadata: asObject(row.metadata),
      });
    }
  }

  return insertedRows;
}

async function sendPushNotifications(rows: NotificationRow[]) {
  if (rows.length === 0 || !isFcmConfigured()) {
    return { sent: 0, failed: 0 };
  }

  const tokensByUserId = await fetchPushTokensByUserIds(
    Array.from(new Set(rows.map((row) => row.recipient_user_id))),
  );
  if (tokensByUserId.size === 0) {
    return { sent: 0, failed: 0 };
  }

  const accessToken = await getFcmAccessToken();
  let sent = 0;
  let failed = 0;

  for (const row of rows) {
    const tokens = tokensByUserId.get(row.recipient_user_id) ?? [];
    for (const tokenRow of tokens) {
      const result = await sendFcmMessage(accessToken, tokenRow, row);
      if (result.ok) {
        sent += 1;
        continue;
      }

      failed += 1;
      if (result.invalidToken) {
        await deactivatePushToken(tokenRow.id);
      }
    }
  }

  return { sent, failed };
}

async function fetchPushTokensByUserIds(userIds: string[]) {
  if (userIds.length === 0) {
    return new Map<string, PushTokenRow[]>();
  }

  const { data, error } = await supabase
    .from("user_push_tokens")
    .select("id, user_id, token, platform")
    .in("user_id", userIds)
    .eq("is_active", true);

  if (error) {
    throw error;
  }

  const result = new Map<string, PushTokenRow[]>();
  for (const row of data ?? []) {
    const userId = String(row.user_id ?? "").trim();
    const token = String(row.token ?? "").trim();
    if (!userId || !token) {
      continue;
    }

    const current = result.get(userId) ?? [];
    current.push({
      id: String(row.id),
      user_id: userId,
      token,
      platform: String(row.platform ?? "unknown"),
    });
    result.set(userId, current);
  }

  return result;
}

async function sendFcmMessage(
  accessToken: string,
  tokenRow: PushTokenRow,
  row: NotificationRow,
) {
  const response = await fetch(
    `https://fcm.googleapis.com/v1/projects/${fcmProjectId}/messages:send`,
    {
      method: "POST",
      headers: {
        authorization: `Bearer ${accessToken}`,
        "content-type": "application/json; charset=utf-8",
      },
      body: JSON.stringify({
        message: {
          token: tokenRow.token,
          notification: {
            title: row.title,
            body: row.body,
          },
          data: {
            notificationId: row.id,
            notificationType: row.notification_type,
            entityType: row.entity_type,
            entityId: row.entity_id,
            sourceTable: row.source_table,
            sourceRecordId: row.source_record_id,
            imageUrl: row.image_url,
          },
          android: {
            priority: "high",
            notification: {
              channelId: "community_updates",
              image: row.image_url || undefined,
            },
          },
          apns: {
            payload: {
              aps: {
                sound: "default",
                badge: 1,
              },
            },
            fcm_options: row.image_url
              ? {
                  image: row.image_url,
                }
              : undefined,
          },
        },
      }),
    },
  );

  if (response.ok) {
    return { ok: true, invalidToken: false };
  }

  const responseText = await response.text();
  console.error(
    `FCM send failed for token ${tokenRow.id}: ${response.status} ${responseText}`,
  );

  return {
    ok: false,
    invalidToken: response.status === 404 ||
      responseText.includes("UNREGISTERED") ||
      responseText.includes("registration-token-not-registered") ||
      responseText.includes("invalid-registration-token"),
  };
}

async function deactivatePushToken(tokenId: string) {
  const { error } = await supabase
    .from("user_push_tokens")
    .update({
      is_active: false,
      updated_at: new Date().toISOString(),
    })
    .eq("id", tokenId);

  if (error) {
    console.error(`Failed to deactivate push token ${tokenId}`, error);
  }
}

function isFcmConfigured() {
  return Boolean(
    fcmProjectId.trim() &&
      fcmClientEmail.trim() &&
      fcmPrivateKey.trim(),
  );
}

async function getFcmAccessToken() {
  const issuedAt = Math.floor(Date.now() / 1000);
  const expiresAt = issuedAt + 3600;
  const jwt = await createJwt({
    iss: fcmClientEmail,
    sub: fcmClientEmail,
    aud: "https://oauth2.googleapis.com/token",
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    iat: issuedAt,
    exp: expiresAt,
  });

  const response = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: {
      "content-type": "application/x-www-form-urlencoded",
    },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });

  if (!response.ok) {
    throw new Error(`Unable to fetch FCM access token: ${await response.text()}`);
  }

  const payload = await response.json() as { access_token?: string };
  const accessToken = String(payload.access_token ?? "").trim();
  if (!accessToken) {
    throw new Error("FCM access token response is empty.");
  }

  return accessToken;
}

async function createJwt(payload: Record<string, string | number>) {
  const header = { alg: "RS256", typ: "JWT" };
  const unsignedJwt = `${base64UrlEncodeJson(header)}.${base64UrlEncodeJson(payload)}`;
  const signature = await signWithPrivateKey(unsignedJwt, fcmPrivateKey);
  return `${unsignedJwt}.${signature}`;
}

async function signWithPrivateKey(value: string, privateKeyPem: string) {
  const pemContents = privateKeyPem
    .replace("-----BEGIN PRIVATE KEY-----", "")
    .replace("-----END PRIVATE KEY-----", "")
    .replace(/\s+/g, "");
  const keyBuffer = Uint8Array.from(atob(pemContents), (char) =>
    char.charCodeAt(0)
  );
  const cryptoKey = await crypto.subtle.importKey(
    "pkcs8",
    keyBuffer.buffer,
    {
      name: "RSASSA-PKCS1-v1_5",
      hash: "SHA-256",
    },
    false,
    ["sign"],
  );

  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    cryptoKey,
    new TextEncoder().encode(value),
  );
  return base64UrlEncodeBytes(new Uint8Array(signature));
}

function base64UrlEncodeJson(value: Record<string, string | number>) {
  return base64UrlEncodeBytes(
    new TextEncoder().encode(JSON.stringify(value)),
  );
}

function base64UrlEncodeBytes(value: Uint8Array) {
  const encoded = btoa(String.fromCharCode(...value));
  return encoded.replaceAll("+", "-").replaceAll("/", "_").replaceAll("=", "");
}

function asObject(value: unknown) {
  if (value && typeof value === "object" && !Array.isArray(value)) {
    return value as Record<string, unknown>;
  }
  return {};
}

function buildPostSummary(record: JsonRecord) {
  return firstNonEmpty(
    trimToLength(readString(record, "content"), 120),
    trimToLength(readString(record, "movie_title"), 120),
    "Chạm để xem bài viết mới.",
  );
}

function buildStorySummary(record: JsonRecord) {
  return firstNonEmpty(
    trimToLength(readString(record, "caption"), 120),
    trimToLength(readString(record, "movie_title"), 120),
    "Chạm để xem tin mới.",
  );
}

function buildCommentSummary(record: JsonRecord) {
  return firstNonEmpty(
    trimToLength(readString(record, "content"), 120),
    "Chạm để xem bình luận mới.",
  );
}

function chunked<T>(items: T[], size: number): T[][] {
  const chunks: T[][] = [];
  for (let index = 0; index < items.length; index += size) {
    chunks.push(items.slice(index, index + size));
  }
  return chunks;
}

function trimToLength(value: string, maxLength: number) {
  const normalized = value.trim();
  if (normalized.length <= maxLength) {
    return normalized;
  }
  return `${normalized.slice(0, maxLength - 1).trimEnd()}…`;
}

function readString(record: JsonRecord, key: string) {
  const value = record[key];
  if (typeof value === "string") {
    return value.trim();
  }
  if (typeof value === "number" || typeof value === "boolean") {
    return String(value);
  }
  return "";
}

function firstNonEmpty(...values: string[]) {
  for (const value of values) {
    const normalized = value.trim();
    if (normalized.length > 0) {
      return normalized;
    }
  }
  return "";
}

function assertRequired(value: string, fieldName: string) {
  if (value.trim().length === 0) {
    throw new Error(`Missing required field: ${fieldName}`);
  }
}

function jsonResponse(
  body: Record<string, unknown>,
  init: ResponseInit = {},
) {
  return new Response(JSON.stringify(body), {
    ...init,
    headers: {
      "content-type": "application/json; charset=utf-8",
      ...(init.headers ?? {}),
    },
  });
}
