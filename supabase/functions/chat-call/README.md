# call-chat Edge Function

Control-plane endpoint for chat messages and Agora call sessions.

Required secrets:

- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`
- `AGORA_APP_ID`
- `AGORA_APP_CERTIFICATE`
- `AGORA_CHAT_REST_DOMAIN`
- `AGORA_CHAT_ORG_NAME`
- `AGORA_CHAT_APP_NAME`
- `FCM_PROJECT_ID`
- `FCM_CLIENT_EMAIL`
- `FCM_PRIVATE_KEY`

`FCM_PRIVATE_KEY` can keep the original PEM newlines or use escaped `\n`
newlines. The function sends chat/call pushes directly through FCM after
creating rows in `community_notifications`.

Actions expected by Flutter:

- `get_or_create_direct_conversation`
- `get_agora_chat_session`
- `notify_agora_chat_message`
- `send_text_message`
- `start_call`
- `answer_call`
- `decline_call`
- `end_call`

The function must validate the caller from the Supabase JWT, enforce
conversation membership, provision Agora Chat users, generate short-lived Agora
Chat and RTC tokens server-side, and send chat/call pushes to the other
participants.

Deploy with Deno npm imports enabled; the implementation uses
`agora-access-token` to generate one-hour RTC publisher tokens and
`agora-token` to generate Agora Chat app/user tokens.
