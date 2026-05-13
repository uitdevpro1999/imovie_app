-- Add real unread counts for Agora-backed chat conversations.
-- Run after chat_call.sql.

alter table public.chat_participants
  add column if not exists last_read_at timestamptz;

update public.chat_participants
set last_read_at = now()
where last_read_at is null;

create or replace view public.chat_conversation_summaries as
select
  auth.uid() as current_user_id,
  c.id,
  c.type,
  case
    when c.type = 'group' and c.title <> '' then c.title
    else coalesce(other_profile.full_name, c.title, 'Cuộc trò chuyện')
  end as display_title,
  coalesce(other_profile.avatar_url, '') as display_avatar_url,
  array_agg(cp.user_id::text) as participant_ids,
  coalesce(nullif(c.last_message_preview, ''), '') as last_message_preview,
  c.last_message_at,
  coalesce(unread.unread_count, 0)::int as unread_count,
  c.type = 'direct' as is_direct
from public.chat_conversations c
join public.chat_participants mine
  on mine.conversation_id = c.id and mine.user_id = auth.uid()
join public.chat_participants cp on cp.conversation_id = c.id
left join lateral (
  select count(*) as unread_count
  from public.chat_message_events e
  where e.conversation_id = c.id
    and e.sender_id <> auth.uid()
    and (
      mine.last_read_at is null
      or e.created_at > mine.last_read_at
    )
) unread on true
left join public.chat_participants other_participant
  on other_participant.conversation_id = c.id
  and other_participant.user_id <> auth.uid()
left join public.profiles other_profile
  on other_profile.id = other_participant.user_id
group by
  c.id,
  c.last_message_preview,
  other_profile.full_name,
  other_profile.avatar_url,
  unread.unread_count;

create or replace function public.mark_chat_conversation_read(
  target_conversation_id uuid
) returns void language plpgsql security definer set search_path = public as $$
begin
  if not exists (
    select 1 from public.chat_participants
    where conversation_id = target_conversation_id and user_id = auth.uid()
  ) then
    raise exception 'Not a participant';
  end if;

  update public.chat_participants
  set last_read_message_id = null,
      last_read_at = now()
  where conversation_id = target_conversation_id and user_id = auth.uid();
end;
$$;

do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'chat_participants'
  ) then
    alter publication supabase_realtime add table public.chat_participants;
  end if;
end;
$$;
