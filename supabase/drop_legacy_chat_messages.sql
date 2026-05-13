-- Drop the legacy Supabase chat message store after migrating chat history to
-- Agora Chat. Run this only after `chat_call.sql` has been applied and
-- `call-chat` has been redeployed with `chat_message_events` notifications.

delete from public.community_notifications
where source_table = 'chat_messages';

do $$
begin
  if exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'chat_messages'
  ) then
    alter publication supabase_realtime drop table public.chat_messages;
  end if;
end;
$$;

drop policy if exists "chat messages are visible to participants"
on public.chat_messages;

alter table if exists public.chat_conversations
  drop constraint if exists chat_conversations_last_message_id_fkey;

alter table if exists public.chat_conversations
  drop column if exists last_message_id;

drop table if exists public.chat_messages cascade;
