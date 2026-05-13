-- Fix RLS recursion caused by policies on chat_participants querying
-- chat_participants directly.

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
