import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { RtcRole, RtcTokenBuilder } from 'npm:agora-access-token';
import { ChatTokenBuilder } from 'npm:agora-token';

type Action =
  | 'get_or_create_direct_conversation'
  | 'get_agora_chat_session'
  | 'notify_agora_chat_message'
  | 'send_text_message'
  | 'start_call'
  | 'get_call'
  | 'answer_call'
  | 'decline_call'
  | 'end_call';

type NotificationRow = {
  id: string;
  recipient_user_id: string;
  actor_user_id: string;
  actor_name: string;
  actor_avatar_url: string;
  notification_type: string;
  source_table: string;
  source_record_id: string;
  entity_type: string;
  entity_id: string;
  title: string;
  body: string;
  image_url: string;
  metadata: Record<string, unknown>;
};

type NotificationInsert = Omit<NotificationRow, 'id'>;

type NotificationSnapshot = {
  recipient_user_id: string;
  source_table: string;
  source_record_id: string;
  notification_type: string;
  metadata: Record<string, unknown>;
};

type PushTokenRow = {
  id: string;
  user_id: string;
  token: string;
  platform: string;
};

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
};

const fcmProjectId = Deno.env.get('FCM_PROJECT_ID') ?? '';
const fcmClientEmail = Deno.env.get('FCM_CLIENT_EMAIL') ?? '';
const fcmPrivateKey = (Deno.env.get('FCM_PRIVATE_KEY') ?? '').replaceAll(
  String.raw`\n`,
  '\n',
);

function logInfo(event: string, payload: Record<string, unknown> = {}) {
  console.log(JSON.stringify({ level: 'info', event, ...payload }));
}

function logError(event: string, payload: Record<string, unknown> = {}) {
  console.error(JSON.stringify({ level: 'error', event, ...payload }));
}

function errorMessage(error: unknown) {
  if (error instanceof Error) return error.message;
  if (typeof error === 'string') return error;
  try {
    return JSON.stringify(error);
  } catch (_) {
    return String(error);
  }
}

function errorDetails(error: unknown) {
  if (!error || typeof error !== 'object') return undefined;
  const value = error as Record<string, unknown>;
  return {
    name: value.name,
    message: value.message,
    code: value.code,
    details: value.details,
    hint: value.hint,
    status: value.status,
    statusText: value.statusText,
  };
}

function safeId(value: unknown) {
  const text = String(value ?? '');
  if (text.length <= 12) return text;
  return `${text.slice(0, 8)}...${text.slice(-4)}`;
}

async function deterministicUuid(input: string) {
  const bytes = new TextEncoder().encode(input);
  const hash = new Uint8Array(await crypto.subtle.digest('SHA-256', bytes));
  hash[6] = (hash[6] & 0x0f) | 0x50;
  hash[8] = (hash[8] & 0x3f) | 0x80;
  const hex = Array.from(hash.slice(0, 16), (byte) =>
    byte.toString(16).padStart(2, '0')
  ).join('');
  return [
    hex.slice(0, 8),
    hex.slice(8, 12),
    hex.slice(12, 16),
    hex.slice(16, 20),
    hex.slice(20, 32),
  ].join('-');
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? '';
  const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';
  const authHeader = req.headers.get('Authorization') ?? '';
  const authSupabase = createClient(supabaseUrl, serviceRoleKey, {
    global: { headers: { Authorization: authHeader } },
  });
  const supabase = createClient(supabaseUrl, serviceRoleKey);

  const { data: userResult, error: userError } =
    await authSupabase.auth.getUser();
  if (userError || !userResult.user) {
    return json({ error: 'Unauthorized' }, 401);
  }

  const userId = userResult.user.id;
  const body = await req.json().catch(() => ({}));
  const action = String(body.action ?? '') as Action;
  const startedAt = Date.now();

  logInfo('chat_call.request.start', {
    action,
    user_id: safeId(userId),
    conversation_id: safeId(body.conversationId),
    target_user_id: safeId(body.userId),
    call_id: safeId(body.callId),
  });

  try {
    let response: Response;
    switch (action) {
      case 'get_or_create_direct_conversation':
        response = json({
          conversation: await getOrCreateDirectConversation(
            supabase,
            userId,
            String(body.userId ?? ''),
          ),
        });
        break;
      case 'get_agora_chat_session':
        response = json({
          session: await getAgoraChatSession(
            supabase,
            userId,
            String(body.conversationId ?? ''),
          ),
        });
        break;
      case 'notify_agora_chat_message':
        response = json({
          event: await notifyAgoraChatMessage(
            supabase,
            userId,
            String(body.conversationId ?? ''),
            String(body.body ?? ''),
            String(body.agoraMessageId ?? ''),
          ),
        });
        break;
      case 'send_text_message':
        response = json({
          message: await sendTextMessage(
            supabase,
            userId,
            String(body.conversationId ?? ''),
            String(body.body ?? ''),
          ),
        });
        break;
      case 'start_call':
        response = json({
          call: await startCall(
            supabase,
            userId,
            String(body.conversationId ?? ''),
            String(body.type ?? 'audio'),
          ),
        });
        break;
      case 'get_call':
        response = json({
          call: await getCall(supabase, userId, String(body.callId ?? '')),
        });
        break;
      case 'answer_call':
        response = json({
          call: await updateCallStatus(
            supabase,
            userId,
            String(body.callId ?? ''),
            'accepted',
          ),
        });
        break;
      case 'decline_call':
        await updateCallStatus(
          supabase,
          userId,
          String(body.callId ?? ''),
          'declined',
        );
        response = json({ ok: true });
        break;
      case 'end_call':
        await updateCallStatus(
          supabase,
          userId,
          String(body.callId ?? ''),
          'ended',
        );
        response = json({ ok: true });
        break;
      default:
        response = json({ error: 'Unsupported action' }, 400);
    }
    logInfo('chat_call.request.success', {
      action,
      user_id: safeId(userId),
      status: response.status,
      duration_ms: Date.now() - startedAt,
    });
    return response;
  } catch (error) {
    logError('chat_call.request.error', {
      action,
      user_id: safeId(userId),
      duration_ms: Date.now() - startedAt,
      error: errorMessage(error),
      details: errorDetails(error),
      stack: error instanceof Error ? error.stack : undefined,
    });
    return json({ error: errorMessage(error), details: errorDetails(error) }, 400);
  }
});

async function getOrCreateDirectConversation(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  targetUserId: string,
) {
  logInfo('chat_call.conversation.lookup', {
    user_id: safeId(userId),
    target_user_id: safeId(targetUserId),
  });
  if (!targetUserId || targetUserId === userId) {
    throw new Error('Invalid target user');
  }

  const existingConversationId = await findDirectConversationId(
    supabase,
    userId,
    targetUserId,
  );

  if (existingConversationId) {
    logInfo('chat_call.conversation.reuse', {
      conversation_id: safeId(existingConversationId),
      user_id: safeId(userId),
      target_user_id: safeId(targetUserId),
    });
    return buildConversationSummary(supabase, userId, existingConversationId);
  }

  const { data: conversation, error } = await supabase
    .from('chat_conversations')
    .insert({ type: 'direct', created_by: userId })
    .select()
    .single();
  if (error) throw error;

  const { error: participantError } = await supabase
    .from('chat_participants')
    .insert([
      { conversation_id: conversation.id, user_id: userId },
      { conversation_id: conversation.id, user_id: targetUserId },
    ]);
  if (participantError) throw participantError;

  logInfo('chat_call.conversation.created', {
    conversation_id: safeId(conversation.id),
    user_id: safeId(userId),
    target_user_id: safeId(targetUserId),
  });
  return buildConversationSummary(supabase, userId, conversation.id);
}

async function findDirectConversationId(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  targetUserId: string,
) {
  const { data: mine, error: mineError } = await supabase
    .from('chat_participants')
    .select('conversation_id, chat_conversations!inner(type)')
    .eq('user_id', userId)
    .eq('chat_conversations.type', 'direct');
  if (mineError) {
    logError('chat_call.conversation.find.mine_error', {
      user_id: safeId(userId),
      error: mineError,
    });
    throw mineError;
  }

  const conversationIds = (mine ?? [])
    .map((row) => String(row.conversation_id ?? ''))
    .filter((id) => id.length > 0);
  if (conversationIds.length === 0) {
    logInfo('chat_call.conversation.find.none_for_user', {
      user_id: safeId(userId),
    });
    return '';
  }

  const { data: peer, error: peerError } = await supabase
    .from('chat_participants')
    .select('conversation_id')
    .eq('user_id', targetUserId)
    .in('conversation_id', conversationIds)
    .limit(1)
    .maybeSingle();
  if (peerError) {
    logError('chat_call.conversation.find.peer_error', {
      user_id: safeId(userId),
      target_user_id: safeId(targetUserId),
      conversation_count: conversationIds.length,
      error: peerError,
    });
    throw peerError;
  }
  return peer?.conversation_id ? String(peer.conversation_id) : '';
}

async function buildConversationSummary(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  conversationId: string,
) {
  const { data: conversation, error: conversationError } = await supabase
    .from('chat_conversations')
    .select('*')
    .eq('id', conversationId)
    .single();
  if (conversationError) throw conversationError;

  const participants = await fetchConversationParticipantIds(
    supabase,
    conversationId,
  );
  const peerUserId =
    participants.find((participantUserId) => participantUserId !== userId) ??
    '';
  const peerProfile = peerUserId
    ? await resolveProfile(supabase, peerUserId)
    : { name: '', avatarUrl: '' };

  return {
    current_user_id: userId,
    id: conversation.id,
    type: conversation.type,
    display_title:
      conversation.type === 'group' && String(conversation.title ?? '').trim()
        ? conversation.title
        : peerProfile.name || conversation.title || 'Cuộc trò chuyện',
    display_avatar_url: peerProfile.avatarUrl,
    participant_ids: participants,
    last_message_preview: conversation.last_message_preview ?? '',
    last_message_at: conversation.last_message_at,
    unread_count: 0,
    is_direct: conversation.type === 'direct',
  };
}

async function getAgoraChatSession(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  conversationId: string,
) {
  logInfo('chat_call.agora_chat.session.start', {
    user_id: safeId(userId),
    conversation_id: safeId(conversationId),
  });
  const currentUser = await ensureAgoraChatUser(supabase, userId);
  const response: Record<string, unknown> = {
    user_id: userId,
    agora_username: currentUser.agora_username,
    agora_uuid: currentUser.agora_uuid,
    agora_token: generateAgoraChatUserToken(currentUser.agora_uuid),
  };

  if (conversationId.trim()) {
    await assertParticipant(supabase, userId, conversationId);
    const peerUserId = await fetchDirectPeerUserId(
      supabase,
      userId,
      conversationId,
    );
    const peerUser = peerUserId
      ? await ensureAgoraChatUser(supabase, peerUserId)
      : null;
    response.peer_user_id = peerUserId;
    response.peer_agora_username = peerUser?.agora_username ?? '';
    response.peer_agora_uuid = peerUser?.agora_uuid ?? '';
  }

  logInfo('chat_call.agora_chat.session.ready', {
    user_id: safeId(userId),
    conversation_id: safeId(conversationId),
    agora_username: currentUser.agora_username,
    peer_user_id: safeId(response.peer_user_id),
    peer_agora_username: response.peer_agora_username ?? '',
  });
  return response;
}

async function notifyAgoraChatMessage(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  conversationId: string,
  body: string,
  agoraMessageId: string,
) {
  logInfo('chat_call.chat_message.notify.start', {
    user_id: safeId(userId),
    conversation_id: safeId(conversationId),
    agora_message_id: safeId(agoraMessageId),
    body_length: body.trim().length,
  });
  if (!conversationId || !body.trim()) throw new Error('Invalid message');
  await assertParticipant(supabase, userId, conversationId);

  const { data: event, error } = await supabase
    .from('chat_message_events')
    .insert({
      conversation_id: conversationId,
      sender_id: userId,
      agora_message_id: agoraMessageId,
    })
    .select()
    .single();
  if (error) throw error;

  await supabase
    .from('chat_conversations')
    .update({
      last_message_preview: body.trim(),
      last_message_at: event.created_at,
      updated_at: event.created_at,
    })
    .eq('id', conversationId);

  await insertChatNotifications(supabase, userId, conversationId, {
    id: event.id,
    body: body.trim(),
    agora_message_id: agoraMessageId,
  });

  logInfo('chat_call.chat_message.notify.done', {
    user_id: safeId(userId),
    conversation_id: safeId(conversationId),
    event_id: safeId(event.id),
    agora_message_id: safeId(agoraMessageId),
  });
  return event;
}

async function sendTextMessage(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  conversationId: string,
  body: string,
) {
  void supabase;
  void userId;
  void conversationId;
  void body;
  throw new Error('send_text_message is deprecated. Use Agora Chat SDK.');
}

async function startCall(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  conversationId: string,
  type: string,
) {
  logInfo('chat_call.call.start', {
    user_id: safeId(userId),
    conversation_id: safeId(conversationId),
    type,
  });
  await assertParticipant(supabase, userId, conversationId);
  const { data: call, error } = await supabase
    .from('call_sessions')
    .insert({
      conversation_id: conversationId,
      caller_id: userId,
      type: type === 'video' ? 'video' : 'audio',
      agora_channel: `call_${crypto.randomUUID()}`,
      status: 'ringing',
    })
    .select()
    .single();
  if (error) throw error;

  const participants = await fetchConversationParticipantIds(
    supabase,
    conversationId,
  );
  const agoraUid = uidFromUserId(userId);
  const participantRows = participants.map((participantUserId) => ({
    call_id: call.id,
    user_id: participantUserId,
    agora_uid: uidFromUserId(participantUserId),
    status: participantUserId === userId ? 'joined' : 'ringing',
  }));
  const { error: participantsError } = await supabase
    .from('call_participants')
    .insert(participantRows);
  if (participantsError) throw participantsError;

  await insertCallNotifications(supabase, userId, call, participants);

  logInfo('chat_call.call.created', {
    user_id: safeId(userId),
    conversation_id: safeId(conversationId),
    call_id: safeId(call.id),
    participants: participants.map(safeId),
  });
  return await buildCallPayloadForUser(supabase, userId, call, agoraUid);
}

async function fetchConversationParticipantIds(
  supabase: ReturnType<typeof createClient>,
  conversationId: string,
) {
  const { data, error } = await supabase
    .from('chat_participants')
    .select('user_id')
    .eq('conversation_id', conversationId);
  if (error) throw error;
  return (data ?? []).map((row) => String(row.user_id));
}

async function fetchDirectPeerUserId(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  conversationId: string,
) {
  const { data, error } = await supabase
    .from('chat_participants')
    .select('user_id')
    .eq('conversation_id', conversationId)
    .neq('user_id', userId)
    .limit(1)
    .maybeSingle();
  if (error) throw error;
  return data?.user_id ? String(data.user_id) : '';
}

async function insertChatNotifications(
  supabase: ReturnType<typeof createClient>,
  actorUserId: string,
  conversationId: string,
  message: Record<string, unknown>,
) {
  const recipients = (await fetchConversationParticipantIds(
    supabase,
    conversationId,
  )).filter((recipientUserId) => recipientUserId !== actorUserId);
  if (recipients.length === 0) {
    logInfo('chat_call.chat_notifications.skip_no_recipients', {
      actor_user_id: safeId(actorUserId),
      conversation_id: safeId(conversationId),
    });
    return;
  }

  const actor = await resolveProfile(supabase, actorUserId);
  const messageId = String(message.id ?? '');
  const rows: NotificationInsert[] = recipients.map((recipientUserId) => ({
    recipient_user_id: recipientUserId,
    actor_user_id: actorUserId,
    actor_name: actor.name,
    actor_avatar_url: actor.avatarUrl,
    notification_type: 'chat_message',
    source_table: 'chat_message_events',
    source_record_id: messageId,
    entity_type: 'chat',
    entity_id: conversationId,
    title: `${actor.name} đã gửi tin nhắn`,
    body: String(message.body ?? ''),
    image_url: actor.avatarUrl,
    metadata: { conversation_id: conversationId, message_id: messageId },
  }));

  const pushRows = transientNotificationRows(rows);
  const pushResult = await sendPushNotifications(supabase, pushRows);
  logInfo('chat_call.chat_notifications.pushed_without_persisting', {
    actor_user_id: safeId(actorUserId),
    conversation_id: safeId(conversationId),
    recipients: recipients.map(safeId),
    count: pushRows.length,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
  });
}

async function ensureAgoraChatUser(
  supabase: ReturnType<typeof createClient>,
  userId: string,
) {
  const { data: existing, error: existingError } = await supabase
    .from('agora_chat_users')
    .select('*')
    .eq('user_id', userId)
    .maybeSingle();
  if (existingError) throw existingError;
  if (existing) {
    logInfo('chat_call.agora_chat.user.reuse', {
      user_id: safeId(userId),
      agora_username: existing.agora_username,
      agora_uuid: safeId(existing.agora_uuid),
    });
    return existing;
  }

  const username = agoraUsernameFromUserId(userId);
  const profile = await resolveProfile(supabase, userId);
  logInfo('chat_call.agora_chat.user.provision.start', {
    user_id: safeId(userId),
    agora_username: username,
  });
  const agoraUuid = await createOrFetchAgoraChatUser(username, profile.name);

  const { data: created, error } = await supabase
    .from('agora_chat_users')
    .upsert(
      {
        user_id: userId,
        agora_username: username,
        agora_uuid: agoraUuid,
        updated_at: new Date().toISOString(),
      },
      { onConflict: 'user_id' },
    )
    .select()
    .single();
  if (error) throw error;
  logInfo('chat_call.agora_chat.user.provision.done', {
    user_id: safeId(userId),
    agora_username: username,
    agora_uuid: safeId(agoraUuid),
  });
  return created;
}

async function createOrFetchAgoraChatUser(username: string, nickname: string) {
  const baseUrl = agoraChatRestBaseUrl();
  const appToken = generateAgoraChatAppToken();
  const headers = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
    Authorization: `Bearer ${appToken}`,
  };

  const createResponse = await fetch(`${baseUrl}/users`, {
    method: 'POST',
    headers,
    body: JSON.stringify({
      username,
      password: crypto.randomUUID().replaceAll('-', ''),
      nickname,
    }),
  });
  const createPayload = await createResponse.json().catch(() => ({}));
  if (createResponse.ok) {
    const uuid = extractAgoraUserUuid(createPayload);
    if (uuid) {
      logInfo('chat_call.agora_chat.rest.user_created', {
        agora_username: username,
        agora_uuid: safeId(uuid),
      });
      return uuid;
    }
  }

  logInfo('chat_call.agora_chat.rest.user_create_fallback', {
    agora_username: username,
    create_status: createResponse.status,
  });
  const getResponse = await fetch(`${baseUrl}/users/${username}`, {
    method: 'GET',
    headers,
  });
  const getPayload = await getResponse.json().catch(() => ({}));
  if (!getResponse.ok) {
    logError('chat_call.agora_chat.rest.user_fetch_failed', {
      agora_username: username,
      create_status: createResponse.status,
      get_status: getResponse.status,
      create_payload: createPayload,
      get_payload: getPayload,
    });
    throw new Error(
      `Unable to provision Agora Chat user: ${createResponse.status}/${getResponse.status}`,
    );
  }

  const uuid = extractAgoraUserUuid(getPayload);
  if (!uuid) {
    logError('chat_call.agora_chat.rest.user_uuid_missing', {
      agora_username: username,
      get_status: getResponse.status,
      get_payload: getPayload,
    });
    throw new Error('Agora Chat user UUID was not returned');
  }
  logInfo('chat_call.agora_chat.rest.user_fetched', {
    agora_username: username,
    agora_uuid: safeId(uuid),
  });
  return uuid;
}

function extractAgoraUserUuid(payload: unknown): string {
  if (!payload || typeof payload !== 'object') return '';
  const value = payload as Record<string, unknown>;
  const directUuid = value.uuid;
  if (typeof directUuid === 'string' && directUuid.trim()) {
    return directUuid.trim();
  }
  const entities = value.entities;
  if (Array.isArray(entities)) {
    for (const entity of entities) {
      const uuid = extractAgoraUserUuid(entity);
      if (uuid) return uuid;
    }
  }
  const data = value.data;
  if (data && typeof data === 'object') {
    return extractAgoraUserUuid(data);
  }
  return '';
}

function agoraUsernameFromUserId(userId: string) {
  return `u_${userId.replaceAll('-', '').toLowerCase()}`;
}

function agoraChatRestBaseUrl() {
  const domain = (Deno.env.get('AGORA_CHAT_REST_DOMAIN') ?? '').replace(
    /\/$/,
    '',
  );
  const orgName = Deno.env.get('AGORA_CHAT_ORG_NAME') ?? '';
  const appName = Deno.env.get('AGORA_CHAT_APP_NAME') ?? '';
  if (!domain || !orgName || !appName) {
    throw new Error('Agora Chat REST secrets are not configured');
  }
  return `${domain}/${orgName}/${appName}`;
}

function generateAgoraChatAppToken() {
  const appId = Deno.env.get('AGORA_APP_ID') ?? '';
  const appCertificate = Deno.env.get('AGORA_APP_CERTIFICATE') ?? '';
  if (!appId || !appCertificate) {
    throw new Error('Agora token secrets are not configured');
  }
  return ChatTokenBuilder.buildAppToken(appId, appCertificate, 60 * 60);
}

function generateAgoraChatUserToken(agoraUuid: string) {
  const appId = Deno.env.get('AGORA_APP_ID') ?? '';
  const appCertificate = Deno.env.get('AGORA_APP_CERTIFICATE') ?? '';
  if (!appId || !appCertificate) {
    throw new Error('Agora token secrets are not configured');
  }
  return ChatTokenBuilder.buildUserToken(
    appId,
    appCertificate,
    agoraUuid,
    60 * 60,
  );
}

async function insertCallNotifications(
  supabase: ReturnType<typeof createClient>,
  actorUserId: string,
  call: Record<string, unknown>,
  participantIds: string[],
) {
  const recipients = participantIds.filter(
    (recipientUserId) => recipientUserId !== actorUserId,
  );
  if (recipients.length === 0) {
    logInfo('chat_call.call_notifications.skip_no_recipients', {
      actor_user_id: safeId(actorUserId),
      call_id: safeId(call.id),
    });
    return;
  }

  const actor = await resolveProfile(supabase, actorUserId);
  const callId = String(call.id ?? '');
  const conversationId = String(call.conversation_id ?? '');
  const callType = String(call.type ?? '');
  const agoraChannel = String(call.agora_channel ?? '');
  const rows: NotificationInsert[] = recipients.map((recipientUserId) => ({
    recipient_user_id: recipientUserId,
    actor_user_id: actorUserId,
    actor_name: actor.name,
    actor_avatar_url: actor.avatarUrl,
    notification_type: 'incoming_call',
    source_table: 'call_sessions',
    source_record_id: callId,
    entity_type: 'call',
    entity_id: callId,
    title: `${actor.name} đang gọi cho bạn`,
    body: callType === 'video' ? 'Cuộc gọi video' : 'Cuộc gọi thoại',
    image_url: actor.avatarUrl,
    metadata: {
      call_id: callId,
      conversation_id: conversationId,
      call_type: callType,
      agora_channel: agoraChannel,
    },
  }));

  const pushRows = transientNotificationRows(rows);
  const pushResult = await sendPushNotifications(supabase, pushRows);
  logInfo('chat_call.call_notifications.pushed_without_persisting', {
    actor_user_id: safeId(actorUserId),
    call_id: safeId(call.id),
    recipients: recipients.map(safeId),
    count: pushRows.length,
    pushed_rows: pushRows.length,
    skipped_push_rows: 0,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
  });
}

function normalizeNotificationRows(rows: Record<string, unknown>[]) {
  return rows.map((row): NotificationRow => ({
    id: String(row.id ?? ''),
    recipient_user_id: String(row.recipient_user_id ?? ''),
    actor_user_id: String(row.actor_user_id ?? ''),
    actor_name: String(row.actor_name ?? ''),
    actor_avatar_url: String(row.actor_avatar_url ?? ''),
    notification_type: String(row.notification_type ?? ''),
    source_table: String(row.source_table ?? ''),
    source_record_id: String(row.source_record_id ?? ''),
    entity_type: String(row.entity_type ?? ''),
    entity_id: String(row.entity_id ?? ''),
    title: String(row.title ?? ''),
    body: String(row.body ?? ''),
    image_url: String(row.image_url ?? ''),
    metadata: asObject(row.metadata),
  }));
}

function transientNotificationRows(rows: NotificationInsert[]) {
  return rows.map((row): NotificationRow => ({
    id: row.source_record_id,
    ...row,
  }));
}

async function upsertCallNotificationRows(
  supabase: ReturnType<typeof createClient>,
  rows: NotificationInsert[],
) {
  if (rows.length === 0) {
    return {
      rows: [] as NotificationRow[],
      pushRows: [] as NotificationRow[],
      skippedPushRows: 0,
    };
  }

  const recipientIds = Array.from(
    new Set(rows.map((row) => row.recipient_user_id).filter(Boolean)),
  );
  const sourceRecordIds = Array.from(
    new Set(rows.map((row) => row.source_record_id).filter(Boolean)),
  );
  const existingByKey = new Map<string, NotificationSnapshot>();

  if (recipientIds.length > 0 && sourceRecordIds.length > 0) {
    const { data, error } = await supabase
      .from('community_notifications')
      .select(`
        recipient_user_id,
        source_table,
        source_record_id,
        notification_type,
        metadata
      `)
      .eq('source_table', 'call_sessions')
      .in('recipient_user_id', recipientIds)
      .in('source_record_id', sourceRecordIds);

    if (error) throw error;
    for (const row of data ?? []) {
      const snapshot = {
        recipient_user_id: String(row.recipient_user_id ?? ''),
        source_table: String(row.source_table ?? ''),
        source_record_id: String(row.source_record_id ?? ''),
        notification_type: String(row.notification_type ?? ''),
        metadata: asObject(row.metadata),
      };
      existingByKey.set(notificationKey(snapshot), snapshot);
    }
  }

  const { data, error } = await supabase
    .from('community_notifications')
    .upsert(rows, {
      onConflict: 'recipient_user_id,source_table,source_record_id',
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
  if (error) throw error;

  const upsertedRows = normalizeNotificationRows(data ?? []);
  const pushRows = upsertedRows.filter((row) => {
    const previous = existingByKey.get(notificationKey(row));
    if (!previous) return true;
    return notificationChanged(previous, row);
  });

  return {
    rows: upsertedRows,
    pushRows,
    skippedPushRows: upsertedRows.length - pushRows.length,
  };
}

function notificationKey(row: {
  recipient_user_id: string;
  source_table: string;
  source_record_id: string;
}) {
  return `${row.recipient_user_id}:${row.source_table}:${row.source_record_id}`;
}

function notificationChanged(
  previous: NotificationSnapshot,
  next: NotificationRow,
) {
  if (previous.notification_type !== next.notification_type) {
    return true;
  }

  return readMetadataString(previous.metadata, 'call_status') !==
    readMetadataString(next.metadata, 'call_status');
}

async function sendPushNotifications(
  supabase: ReturnType<typeof createClient>,
  rows: NotificationRow[],
) {
  if (rows.length === 0) {
    return { sent: 0, failed: 0 };
  }
  if (!isFcmConfigured()) {
    logError('chat_call.push.skip_missing_fcm_config', {
      rows: rows.length,
    });
    return { sent: 0, failed: rows.length };
  }

  const recipientIds = Array.from(new Set(
    rows.map((row) => row.recipient_user_id).filter(Boolean),
  ));
  const tokensByUserId = await fetchPushTokensByUserIds(supabase, recipientIds);
  if (tokensByUserId.size === 0) {
    logInfo('chat_call.push.skip_no_tokens', {
      recipients: recipientIds.map(safeId),
      rows: rows.length,
    });
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
        await deactivatePushToken(supabase, tokenRow.id);
      }
    }
  }

  logInfo('chat_call.push.done', {
    rows: rows.length,
    recipients: recipientIds.map(safeId),
    sent,
    failed,
  });
  return { sent, failed };
}

async function fetchPushTokensByUserIds(
  supabase: ReturnType<typeof createClient>,
  userIds: string[],
) {
  if (userIds.length === 0) {
    return new Map<string, PushTokenRow[]>();
  }

  const { data, error } = await supabase
    .from('user_push_tokens')
    .select('id, user_id, token, platform')
    .in('user_id', userIds)
    .eq('is_active', true);
  if (error) throw error;

  const result = new Map<string, PushTokenRow[]>();
  for (const row of data ?? []) {
    const userId = String(row.user_id ?? '').trim();
    const token = String(row.token ?? '').trim();
    if (!userId || !token) continue;

    const current = result.get(userId) ?? [];
    current.push({
      id: String(row.id ?? ''),
      user_id: userId,
      token,
      platform: String(row.platform ?? 'unknown'),
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
  const isIncomingCall = row.notification_type === 'incoming_call';
  const isCallControl = row.notification_type === 'call_declined' ||
    row.notification_type === 'call_ended';
  const isCallNotification = isIncomingCall || isCallControl;
  const response = await fetch(
    `https://fcm.googleapis.com/v1/projects/${fcmProjectId}/messages:send`,
    {
      method: 'POST',
      headers: {
        authorization: `Bearer ${accessToken}`,
        'content-type': 'application/json; charset=utf-8',
      },
      body: JSON.stringify({
        message: {
          token: tokenRow.token,
          notification: {
            title: row.title,
            body: row.body,
          },
          data: buildPushData(row),
          android: {
            priority: 'high',
            ttl: isCallNotification ? '30s' : undefined,
            notification: {
              channelId: 'community_updates_v2',
              icon: 'ic_stat_notification',
              color: '#F8C84B',
              defaultSound: true,
              image: row.image_url || undefined,
            },
          },
          apns: {
            payload: {
              aps: {
                sound: 'default',
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
  logError('chat_call.push.fcm_failed', {
    token_id: safeId(tokenRow.id),
    status: response.status,
    response: responseText,
  });

  return {
    ok: false,
    invalidToken: response.status === 404 ||
      responseText.includes('UNREGISTERED') ||
      responseText.includes('registration-token-not-registered') ||
      responseText.includes('invalid-registration-token'),
  };
}

function buildPushData(row: NotificationRow) {
  const metadata = row.metadata;
  const conversationId = readMetadataString(metadata, 'conversation_id');
  const callId = readMetadataString(metadata, 'call_id') || row.entity_id;
  const callType = readMetadataString(metadata, 'call_type');
  const agoraChannel = readMetadataString(metadata, 'agora_channel');
  const messageId = readMetadataString(metadata, 'message_id') ||
    row.source_record_id;

  return compactStringRecord({
    notificationId: row.id,
    notification_id: row.id,
    notificationType: row.notification_type,
    notification_type: row.notification_type,
    title: row.title,
    body: row.body,
    entityType: row.entity_type,
    entity_type: row.entity_type,
    entityId: row.entity_id,
    entity_id: row.entity_id,
    sourceTable: row.source_table,
    source_table: row.source_table,
    sourceRecordId: row.source_record_id,
    source_record_id: row.source_record_id,
    imageUrl: row.image_url,
    image_url: row.image_url,
    actorId: row.actor_user_id,
    actor_id: row.actor_user_id,
    actorName: row.actor_name,
    actor_name: row.actor_name,
    actorAvatarUrl: row.actor_avatar_url,
    actor_avatar_url: row.actor_avatar_url,
    callerId: row.actor_user_id,
    caller_id: row.actor_user_id,
    callerName: row.actor_name,
    caller_name: row.actor_name,
    callerAvatarUrl: row.actor_avatar_url,
    caller_avatar_url: row.actor_avatar_url,
    conversationId,
    conversation_id: conversationId,
    messageId,
    message_id: messageId,
    callId,
    call_id: callId,
    callType,
    call_type: callType,
    callStatus: readMetadataString(metadata, 'call_status'),
    call_status: readMetadataString(metadata, 'call_status'),
    agoraChannel,
    agora_channel: agoraChannel,
  });
}

function compactStringRecord(values: Record<string, unknown>) {
  const result: Record<string, string> = {};
  for (const [key, value] of Object.entries(values)) {
    const text = String(value ?? '').trim();
    if (text) result[key] = text;
  }
  return result;
}

async function deactivatePushToken(
  supabase: ReturnType<typeof createClient>,
  tokenId: string,
) {
  const { error } = await supabase
    .from('user_push_tokens')
    .update({
      is_active: false,
      updated_at: new Date().toISOString(),
    })
    .eq('id', tokenId);
  if (error) {
    logError('chat_call.push.deactivate_token_failed', {
      token_id: safeId(tokenId),
      error: errorMessage(error),
      details: errorDetails(error),
    });
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
    aud: 'https://oauth2.googleapis.com/token',
    scope: 'https://www.googleapis.com/auth/firebase.messaging',
    iat: issuedAt,
    exp: expiresAt,
  });

  const response = await fetch('https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: {
      'content-type': 'application/x-www-form-urlencoded',
    },
    body: new URLSearchParams({
      grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      assertion: jwt,
    }),
  });

  if (!response.ok) {
    throw new Error(`Unable to fetch FCM access token: ${await response.text()}`);
  }

  const payload = await response.json() as { access_token?: string };
  const accessToken = String(payload.access_token ?? '').trim();
  if (!accessToken) {
    throw new Error('FCM access token response is empty.');
  }
  return accessToken;
}

async function createJwt(payload: Record<string, string | number>) {
  const header = { alg: 'RS256', typ: 'JWT' };
  const unsignedJwt = `${base64UrlEncodeJson(header)}.${
    base64UrlEncodeJson(payload)
  }`;
  const signature = await signWithPrivateKey(unsignedJwt, fcmPrivateKey);
  return `${unsignedJwt}.${signature}`;
}

async function signWithPrivateKey(value: string, privateKeyPem: string) {
  const pemContents = privateKeyPem
    .replace('-----BEGIN PRIVATE KEY-----', '')
    .replace('-----END PRIVATE KEY-----', '')
    .replace(/\s+/g, '');
  const keyBuffer = Uint8Array.from(atob(pemContents), (char) =>
    char.charCodeAt(0)
  );
  const cryptoKey = await crypto.subtle.importKey(
    'pkcs8',
    keyBuffer.buffer,
    {
      name: 'RSASSA-PKCS1-v1_5',
      hash: 'SHA-256',
    },
    false,
    ['sign'],
  );

  const signature = await crypto.subtle.sign(
    'RSASSA-PKCS1-v1_5',
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
  return encoded.replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
}

function asObject(value: unknown) {
  if (value && typeof value === 'object' && !Array.isArray(value)) {
    return value as Record<string, unknown>;
  }
  return {};
}

function readMetadataString(record: Record<string, unknown>, key: string) {
  const value = record[key];
  if (typeof value === 'string') return value.trim();
  if (typeof value === 'number' || typeof value === 'boolean') {
    return String(value);
  }
  return '';
}

async function resolveProfile(
  supabase: ReturnType<typeof createClient>,
  userId: string,
) {
  const { data } = await supabase
    .from('profiles')
    .select('full_name, avatar_url')
    .eq('id', userId)
    .maybeSingle();
  return {
    name: String(data?.full_name ?? 'iMovie user'),
    avatarUrl: String(data?.avatar_url ?? ''),
  };
}

async function buildCallPayloadForUser(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  call: Record<string, unknown>,
  agoraUid: number,
) {
  const callerId = String(call.caller_id ?? '');
  const conversationId = String(call.conversation_id ?? '');
  const participantIds = conversationId
    ? await fetchConversationParticipantIds(supabase, conversationId)
    : [];
  const displayUserId =
    callerId === userId
      ? participantIds.find((participantUserId) => participantUserId !== userId) ??
        callerId
      : callerId;
  const callerProfile = callerId
    ? await resolveProfile(supabase, callerId)
    : { name: 'iMovie user', avatarUrl: '' };
  const displayProfile = displayUserId
    ? await resolveProfile(supabase, displayUserId)
    : callerProfile;

  return {
    ...call,
    caller_name: callerProfile.name,
    caller_avatar_url: callerProfile.avatarUrl,
    display_name: displayProfile.name,
    display_avatar_url: displayProfile.avatarUrl,
    agora_uid: agoraUid,
    agora_token: await generateAgoraToken(String(call.agora_channel ?? ''), agoraUid),
  };
}

async function getCall(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  callId: string,
) {
  logInfo('chat_call.call.get', {
    user_id: safeId(userId),
    call_id: safeId(callId),
  });
  if (!callId) throw new Error('Invalid call');

  const { data: call, error } = await supabase
    .from('call_sessions')
    .select()
    .eq('id', callId)
    .single();
  if (error) throw error;

  await assertParticipant(
    supabase,
    userId,
    String(call.conversation_id ?? ''),
  );
  return await buildCallPayloadForUser(
    supabase,
    userId,
    call,
    uidFromUserId(userId),
  );
}

async function updateCallStatus(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  callId: string,
  status: string,
) {
  logInfo('chat_call.call.status_update.start', {
    user_id: safeId(userId),
    call_id: safeId(callId),
    status,
  });
  if (!callId) throw new Error('Invalid call');

  const { data: call, error } = await supabase
    .from('call_sessions')
    .update({
      status,
      accepted_at: status === 'accepted' ? new Date().toISOString() : undefined,
      ended_at: ['ended', 'declined'].includes(status)
        ? new Date().toISOString()
        : undefined,
    })
    .eq('id', callId)
    .select()
    .single();
  if (error) throw error;

  if (status === 'declined' || status === 'ended') {
    await insertCallStatusNotification(supabase, userId, call, status);
  }

  const agoraUid = uidFromUserId(userId);
  await supabase
    .from('call_participants')
    .upsert({ call_id: callId, user_id: userId, agora_uid: agoraUid, status });

  logInfo('chat_call.call.status_update.done', {
    user_id: safeId(userId),
    call_id: safeId(callId),
    status,
    agora_uid: agoraUid,
  });
  return await buildCallPayloadForUser(supabase, userId, call, agoraUid);
}

async function insertCallStatusNotification(
  supabase: ReturnType<typeof createClient>,
  actorUserId: string,
  call: Record<string, unknown>,
  status: string,
) {
  const callerId = String(call.caller_id ?? '').trim();
  const conversationId = String(call.conversation_id ?? '').trim();
  const recipients = status === 'declined'
    ? [callerId].filter((recipientUserId) =>
      recipientUserId && recipientUserId !== actorUserId
    )
    : (await fetchConversationParticipantIds(supabase, conversationId)).filter(
      (recipientUserId) => recipientUserId !== actorUserId,
    );

  if (recipients.length === 0) {
    logInfo('chat_call.call_status_notifications.skip_no_recipient', {
      actor_user_id: safeId(actorUserId),
      call_id: safeId(call.id),
      status,
    });
    return;
  }

  const actor = await resolveProfile(supabase, actorUserId);
  const callId = String(call.id ?? '');
  const sourceRecordId = await deterministicUuid(`call:${callId}:${status}`);
  const callType = String(call.type ?? '');
  const title = status === 'declined'
    ? `${actor.name} đã từ chối cuộc gọi`
    : `${actor.name} đã kết thúc cuộc gọi`;
  const body = callType === 'video' ? 'Cuộc gọi video' : 'Cuộc gọi thoại';
  const notificationType = status === 'declined' ? 'call_declined' : 'call_ended';
  const rows: NotificationInsert[] = recipients.map((recipientUserId) => ({
    recipient_user_id: recipientUserId,
    actor_user_id: actorUserId,
    actor_name: actor.name,
    actor_avatar_url: actor.avatarUrl,
    notification_type: notificationType,
    source_table: 'call_sessions',
    source_record_id: sourceRecordId,
    entity_type: 'call',
    entity_id: callId,
    title,
    body,
    image_url: actor.avatarUrl,
    metadata: {
      call_id: callId,
      conversation_id: conversationId,
      call_type: callType,
      call_status: status,
      source_call_id: callId,
    },
  }));

  const { rows: upsertedRows, pushRows, skippedPushRows } =
    await upsertCallNotificationRows(supabase, rows);
  const pushResult = await sendPushNotifications(supabase, pushRows);
  logInfo('chat_call.call_status_notifications.upserted', {
    actor_user_id: safeId(actorUserId),
    recipients: recipients.map(safeId),
    call_id: safeId(call.id),
    status,
    count: upsertedRows.length,
    pushed_rows: pushRows.length,
    skipped_push_rows: skippedPushRows,
    pushed: pushResult.sent,
    push_failed: pushResult.failed,
  });
}

async function assertParticipant(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  conversationId: string,
) {
  const { data, error } = await supabase
    .from('chat_participants')
    .select('conversation_id')
    .eq('conversation_id', conversationId)
    .eq('user_id', userId)
    .maybeSingle();
  if (error || !data) throw new Error('Not a participant');
}

function uidFromUserId(userId: string) {
  const hex = userId.replaceAll('-', '').slice(0, 8);
  return Number.parseInt(hex, 16) % 2147483647;
}

async function generateAgoraToken(channelName: string, uid: number) {
  const appId = Deno.env.get('AGORA_APP_ID') ?? '';
  const appCertificate = Deno.env.get('AGORA_APP_CERTIFICATE') ?? '';
  if (!appId || !appCertificate) {
    throw new Error('Agora token secrets are not configured');
  }

  const expireSeconds = 60 * 60;
  const privilegeExpiredTs = Math.floor(Date.now() / 1000) + expireSeconds;
  return RtcTokenBuilder.buildTokenWithUid(
    appId,
    appCertificate,
    channelName,
    uid,
    RtcRole.PUBLISHER,
    privilegeExpiredTs,
  );
}

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}
