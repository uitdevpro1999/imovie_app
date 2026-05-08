-- Supabase Realtime Broadcast contract for community features.
-- Topics:
--   community:community_posts
--   community:community_stories
--   community:community_comments
--   community:community_reactions
--   community:community_follows
--   community:profiles

alter table if exists realtime.messages enable row level security;

drop policy if exists "authenticated can receive community broadcasts"
  on realtime.messages;
create policy "authenticated can receive community broadcasts"
  on realtime.messages
  for select
  to authenticated
  using (
    realtime.messages.extension = 'broadcast'
    and (select realtime.topic()) like 'community:%'
  );

do $$
begin
  alter publication supabase_realtime add table public.community_posts;
exception when duplicate_object then null;
end; $$;

alter table public.community_posts replica identity full;

do $$
begin
  alter publication supabase_realtime add table public.community_stories;
exception when duplicate_object then null;
end; $$;

do $$
begin
  alter publication supabase_realtime add table public.community_comments;
exception when duplicate_object then null;
end; $$;

do $$
begin
  alter publication supabase_realtime add table public.community_reactions;
exception when duplicate_object then null;
end; $$;

alter table public.community_reactions replica identity full;

do $$
begin
  alter publication supabase_realtime add table public.community_follows;
exception when duplicate_object then null;
end; $$;

alter table public.community_follows replica identity full;

do $$
begin
  alter publication supabase_realtime add table public.profiles;
exception when duplicate_object then null;
end; $$;

create or replace function public.broadcast_community_table_changes()
returns trigger
language plpgsql
security definer
set search_path = public, realtime
as $$
declare
  topic text := 'community:' || tg_table_name;
begin
  perform realtime.broadcast_changes(
    topic,
    tg_op,
    tg_op,
    tg_table_name,
    tg_table_schema,
    new,
    old
  );

  return null;
end;
$$;

drop trigger if exists community_posts_broadcast_changes
  on public.community_posts;
create trigger community_posts_broadcast_changes
  after insert or update or delete
  on public.community_posts
  for each row
  execute function public.broadcast_community_table_changes();

drop trigger if exists community_stories_broadcast_changes
  on public.community_stories;
create trigger community_stories_broadcast_changes
  after insert or update or delete
  on public.community_stories
  for each row
  execute function public.broadcast_community_table_changes();

drop trigger if exists community_comments_broadcast_changes
  on public.community_comments;
create trigger community_comments_broadcast_changes
  after insert or update or delete
  on public.community_comments
  for each row
  execute function public.broadcast_community_table_changes();

drop trigger if exists community_reactions_broadcast_changes
  on public.community_reactions;
create trigger community_reactions_broadcast_changes
  after insert or update or delete
  on public.community_reactions
  for each row
  execute function public.broadcast_community_table_changes();

drop trigger if exists community_follows_broadcast_changes
  on public.community_follows;
create trigger community_follows_broadcast_changes
  after insert or update or delete
  on public.community_follows
  for each row
  execute function public.broadcast_community_table_changes();

drop trigger if exists community_profiles_broadcast_changes
  on public.profiles;
create trigger community_profiles_broadcast_changes
  after insert or update of full_name, avatar_url, cover_url
  on public.profiles
  for each row
  execute function public.broadcast_community_table_changes();
