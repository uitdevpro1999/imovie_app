create extension if not exists pgcrypto;

create table if not exists public.community_notifications (
  id uuid primary key default gen_random_uuid(),
  recipient_user_id uuid not null references auth.users(id) on delete cascade,
  actor_user_id uuid not null references auth.users(id) on delete cascade,
  actor_name text not null default '',
  actor_avatar_url text not null default '',
  notification_type text not null
    check (
      notification_type in (
        'new_post',
        'new_story',
        'post_comment',
        'post_reaction',
        'new_follower'
      )
    ),
  source_table text not null
    check (
      source_table in (
        'community_posts',
        'community_stories',
        'community_comments',
        'community_reactions',
        'community_follows'
      )
    ),
  source_record_id uuid not null,
  entity_type text not null
    check (entity_type in ('post', 'story', 'profile')),
  entity_id uuid not null,
  title text not null,
  body text not null default '',
  image_url text not null default '',
  metadata jsonb not null default '{}'::jsonb
    check (jsonb_typeof(metadata) = 'object'),
  is_read boolean not null default false,
  read_at timestamptz,
  created_at timestamptz not null default now(),
  constraint community_notifications_unique_source_per_recipient
    unique (recipient_user_id, source_table, source_record_id)
);

alter table public.community_notifications
  add column if not exists actor_name text not null default '',
  add column if not exists actor_avatar_url text not null default '';

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
        'new_follower'
      )
    ),
  add constraint community_notifications_source_table_check
    check (
      source_table in (
        'community_posts',
        'community_stories',
        'community_comments',
        'community_reactions',
        'community_follows'
      )
    ),
  add constraint community_notifications_entity_type_check
    check (entity_type in ('post', 'story', 'profile'));

create index if not exists community_notifications_recipient_created_at_idx
  on public.community_notifications (recipient_user_id, created_at desc);

create index if not exists community_notifications_unread_idx
  on public.community_notifications (recipient_user_id, created_at desc)
  where is_read = false;

alter table public.community_notifications enable row level security;

drop policy if exists "Users can read their community notifications"
  on public.community_notifications;
create policy "Users can read their community notifications"
  on public.community_notifications
  for select
  using (auth.uid() = recipient_user_id);

drop policy if exists "Users can delete their community notifications"
  on public.community_notifications;
create policy "Users can delete their community notifications"
  on public.community_notifications
  for delete
  using (auth.uid() = recipient_user_id);

create or replace function public.mark_community_notification_read(
  target_notification_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.community_notifications
    set
      is_read = true,
      read_at = coalesce(read_at, now())
    where id = target_notification_id
      and recipient_user_id = auth.uid();
end;
$$;

grant execute on function public.mark_community_notification_read(uuid)
  to authenticated;

create or replace function public.mark_all_community_notifications_read()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.community_notifications
    set
      is_read = true,
      read_at = coalesce(read_at, now())
    where recipient_user_id = auth.uid()
      and is_read = false;
end;
$$;

grant execute on function public.mark_all_community_notifications_read()
  to authenticated;
