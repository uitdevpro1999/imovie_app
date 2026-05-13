-- Chat + Agora call control plane.
-- Run after profile/user_push_tokens migrations.

create extension if not exists pgcrypto;

create table if not exists public.chat_conversations (
  id uuid primary key default gen_random_uuid(),
  type text not null default 'direct' check (type in ('direct', 'group')),
  title text not null default '',
  created_by uuid not null references auth.users(id) on delete cascade,
  last_message_preview text not null default '',
  last_message_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.chat_conversations
  add column if not exists last_message_preview text not null default '';

create table if not exists public.chat_participants (
  conversation_id uuid not null references public.chat_conversations(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role text not null default 'member',
  last_read_message_id uuid,
  last_read_at timestamptz,
  joined_at timestamptz not null default now(),
  primary key (conversation_id, user_id)
);

alter table public.chat_participants
  add column if not exists last_read_at timestamptz;

create table if not exists public.agora_chat_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  agora_username text not null unique,
  agora_uuid text not null unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.chat_message_events (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.chat_conversations(id) on delete cascade,
  sender_id uuid not null references auth.users(id) on delete cascade,
  agora_message_id text not null default '',
  created_at timestamptz not null default now()
);

create table if not exists public.call_sessions (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.chat_conversations(id) on delete cascade,
  caller_id uuid not null references auth.users(id) on delete cascade,
  type text not null check (type in ('audio', 'video')),
  agora_channel text not null,
  status text not null default 'ringing'
    check (status in ('ringing', 'accepted', 'active', 'ended', 'missed', 'declined', 'cancelled', 'failed')),
  started_at timestamptz not null default now(),
  accepted_at timestamptz,
  ended_at timestamptz,
  ended_reason text
);

create table if not exists public.call_participants (
  call_id uuid not null references public.call_sessions(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  agora_uid integer not null,
  status text not null default 'invited'
    check (status in ('invited', 'ringing', 'accepted', 'declined', 'joined', 'left', 'missed')),
  joined_at timestamptz,
  left_at timestamptz,
  primary key (call_id, user_id)
);

alter table public.community_notifications
  drop constraint if exists community_notifications_notification_type_check,
  drop constraint if exists community_notifications_source_table_check,
  drop constraint if exists community_notifications_entity_type_check;

alter table public.community_notifications
  add constraint community_notifications_notification_type_check
    check (
      notification_type in (
        'new_post',
        'new_story',
        'post_comment',
        'post_reaction',
        'new_follower',
        'chat_message',
        'incoming_call',
        'call_declined',
        'call_ended',
        'missed_call'
      )
    ),
  add constraint community_notifications_source_table_check
    check (
      source_table in (
        'community_posts',
        'community_stories',
        'community_comments',
        'community_reactions',
        'community_follows',
        'chat_message_events',
        'call_sessions'
      )
    ),
  add constraint community_notifications_entity_type_check
    check (entity_type in ('post', 'story', 'profile', 'chat', 'call'));

alter table public.chat_conversations enable row level security;
alter table public.chat_participants enable row level security;
alter table public.agora_chat_users enable row level security;
alter table public.chat_message_events enable row level security;
alter table public.call_sessions enable row level security;
alter table public.call_participants enable row level security;

drop policy if exists "chat conversations are visible to participants"
  on public.chat_conversations;
drop policy if exists "chat participants are visible to same conversation"
  on public.chat_participants;
drop policy if exists "agora chat users are visible to conversation participants"
  on public.agora_chat_users;
drop policy if exists "chat message events are visible to participants"
  on public.chat_message_events;
drop policy if exists "calls are visible to conversation participants"
  on public.call_sessions;
drop policy if exists "call participants are visible to call members"
  on public.call_participants;

create or replace function public.is_chat_participant(
  target_conversation_id uuid,
  target_user_id uuid
) returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.chat_participants cp
    where cp.conversation_id = target_conversation_id
      and cp.user_id = target_user_id
  );
$$;

create or replace function public.shares_chat_conversation(
  target_user_id uuid,
  viewer_user_id uuid
) returns boolean
language sql
security definer
set search_path = public
as $$
  select target_user_id = viewer_user_id
    or exists (
      select 1
      from public.chat_participants mine
      join public.chat_participants peer
        on peer.conversation_id = mine.conversation_id
      where mine.user_id = viewer_user_id
        and peer.user_id = target_user_id
    );
$$;

create policy "chat conversations are visible to participants"
on public.chat_conversations for select
using (public.is_chat_participant(id, auth.uid()));

create policy "chat participants are visible to same conversation"
on public.chat_participants for select
using (public.is_chat_participant(conversation_id, auth.uid()));

create policy "agora chat users are visible to conversation participants"
on public.agora_chat_users for select
using (public.shares_chat_conversation(user_id, auth.uid()));

create policy "chat message events are visible to participants"
on public.chat_message_events for select
using (public.is_chat_participant(conversation_id, auth.uid()));

create policy "calls are visible to conversation participants"
on public.call_sessions for select
using (public.is_chat_participant(conversation_id, auth.uid()));

create policy "call participants are visible to call members"
on public.call_participants for select
using (
  exists (
    select 1
    from public.call_sessions cs
    where cs.id = call_id
      and public.is_chat_participant(cs.conversation_id, auth.uid())
  )
);

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

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'chat_conversations'
  ) then
    alter publication supabase_realtime add table public.chat_conversations;
  end if;

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'call_sessions'
  ) then
    alter publication supabase_realtime add table public.call_sessions;
  end if;
end;
$$;
