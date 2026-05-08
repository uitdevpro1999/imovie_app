# community-notifications

Edge Function này nhận database webhook từ Supabase Community tables, tạo bản ghi vào `public.community_notifications`, rồi gửi push qua FCM cho các device token đang active trong `public.user_push_tokens`.

## Event đang xử lý

- `community_posts` insert:
  follower của tác giả nhận notification `new_post`
- `community_stories` insert:
  follower của tác giả nhận notification `new_story`
- `community_comments` insert:
  chủ bài viết nhận notification `post_comment`
- `community_reactions` insert:
  chủ bài viết nhận notification `post_reaction`
- `community_follows` insert:
  người bị follow nhận notification `new_follower`

Function tự bỏ self-notification:

- bạn tự comment bài của mình thì không tạo notification
- bạn tự like bài của mình thì không tạo notification

## Secrets cần cấu hình

```bash
supabase secrets set \
  SUPABASE_URL="https://<project-ref>.supabase.co" \
  SUPABASE_SERVICE_ROLE_KEY="<service-role-key>" \
  COMMUNITY_WEBHOOK_SECRET="<your-random-secret>" \
  FCM_PROJECT_ID="<firebase-project-id>" \
  FCM_CLIENT_EMAIL="<firebase-service-account-client-email>" \
  FCM_PRIVATE_KEY="<firebase-service-account-private-key>"
```

`FCM_PRIVATE_KEY` cần giữ nguyên private key PEM, hoặc escape newline thành `\n`.

## Deploy

```bash
supabase functions deploy community-notifications --no-verify-jwt
```

`--no-verify-jwt` là bắt buộc nếu gọi function từ Database Webhook thay vì từ app client.

## Database setup

Chạy các file SQL:

```sql
\i supabase/community_notifications.sql
\i supabase/user_push_tokens.sql
```

## Database Webhook cần tạo

Tạo 5 webhook `INSERT`, cùng trỏ tới:

```text
https://<project-ref>.functions.supabase.co/community-notifications
```

Header:

```text
x-webhook-secret: <COMMUNITY_WEBHOOK_SECRET>
```

Từng webhook:

1. `public.community_posts`
2. `public.community_stories`
3. `public.community_comments`
4. `public.community_reactions`
5. `public.community_follows`

## Ghi chú

## Firebase service account

Để lấy `FCM_PROJECT_ID`, `FCM_CLIENT_EMAIL`, `FCM_PRIVATE_KEY`:

1. Vào [Firebase Console](https://console.firebase.google.com/)
2. Chọn project đang dùng cho app
3. `Project settings` > `Service accounts`
4. `Generate new private key`
5. Dùng các field trong JSON tải về:
   - `project_id`
   - `client_email`
   - `private_key`

## Push payload hiện tại

Function gửi:

- `notification.title`
- `notification.body`
- `data.notificationId`
- `data.notificationType`
- `data.entityType`
- `data.entityId`
- `data.sourceTable`
- `data.sourceRecordId`
- `data.imageUrl`

Foreground notification sẽ do app Flutter tự hiển thị lại bằng local notification. Background/terminated sẽ do FCM/OS xử lý.
