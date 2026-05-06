create extension if not exists pgcrypto;

insert into storage.buckets (id, name, public)
values ('community-posts', 'community-posts', true)
on conflict (id) do update set public = excluded.public;

insert into storage.buckets (id, name, public)
values ('community-stories', 'community-stories', true)
on conflict (id) do update set public = excluded.public;

create table if not exists public.community_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  author_name text not null default '',
  author_avatar_url text not null default '',
  content text not null default '',
  image_url text not null default '',
  movie_title text not null default '',
  movie_slug text not null default '',
  movie_poster_url text not null default '',
  location_name text not null default '',
  reaction_count integer not null default 0 check (reaction_count >= 0),
  comment_count integer not null default 0 check (comment_count >= 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.community_posts
  add column if not exists movie_slug text not null default '',
  add column if not exists movie_poster_url text not null default '';

create table if not exists public.community_comments (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.community_posts(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  author_name text not null default '',
  author_avatar_url text not null default '',
  content text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.community_reactions (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.community_posts(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  reaction_type text not null default 'like',
  created_at timestamptz not null default now(),
  constraint community_reactions_user_post_unique unique (user_id, post_id)
);

create table if not exists public.community_stories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  author_name text not null default '',
  author_avatar_url text not null default '',
  image_url text not null,
  image_path text not null,
  caption text not null default '',
  movie_title text not null default '',
  movie_slug text not null default '',
  movie_poster_url text not null default '',
  location_name text not null default '',
  text_position_x double precision not null default 0.5
    check (text_position_x >= 0 and text_position_x <= 1),
  text_position_y double precision not null default 0.45
    check (text_position_y >= 0 and text_position_y <= 1),
  movie_position_x double precision not null default 0.28
    check (movie_position_x >= 0 and movie_position_x <= 1),
  movie_position_y double precision not null default 0.78
    check (movie_position_y >= 0 and movie_position_y <= 1),
  location_position_x double precision not null default 0.32
    check (location_position_x >= 0 and location_position_x <= 1),
  location_position_y double precision not null default 0.88
    check (location_position_y >= 0 and location_position_y <= 1),
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default now() + interval '24 hours',
  constraint community_stories_expires_after_create
    check (expires_at > created_at)
);

alter table public.community_stories
  add column if not exists movie_title text not null default '',
  add column if not exists movie_slug text not null default '',
  add column if not exists movie_poster_url text not null default '',
  add column if not exists location_name text not null default '',
  add column if not exists text_position_x double precision not null default 0.5,
  add column if not exists text_position_y double precision not null default 0.45,
  add column if not exists movie_position_x double precision not null default 0.28,
  add column if not exists movie_position_y double precision not null default 0.78,
  add column if not exists location_position_x double precision not null default 0.32,
  add column if not exists location_position_y double precision not null default 0.88;

create index if not exists community_posts_created_at_idx
  on public.community_posts (created_at desc);

create index if not exists community_posts_user_created_at_idx
  on public.community_posts (user_id, created_at desc);

create index if not exists community_posts_movie_slug_idx
  on public.community_posts (movie_slug)
  where movie_slug <> '';

create index if not exists community_comments_post_created_at_idx
  on public.community_comments (post_id, created_at);

create index if not exists community_reactions_post_idx
  on public.community_reactions (post_id);

create index if not exists community_stories_active_created_at_idx
  on public.community_stories (expires_at, created_at desc);

create index if not exists community_stories_user_created_at_idx
  on public.community_stories (user_id, created_at desc);

create index if not exists community_stories_movie_slug_idx
  on public.community_stories (movie_slug)
  where movie_slug <> '';

alter table public.community_posts enable row level security;
alter table public.community_comments enable row level security;
alter table public.community_reactions enable row level security;
alter table public.community_stories enable row level security;

drop policy if exists "Authenticated users can read community posts"
  on public.community_posts;
create policy "Authenticated users can read community posts"
  on public.community_posts
  for select
  using (auth.role() = 'authenticated');

drop policy if exists "Users can create their community posts"
  on public.community_posts;
create policy "Users can create their community posts"
  on public.community_posts
  for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their community posts"
  on public.community_posts;
create policy "Users can update their community posts"
  on public.community_posts
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their community posts"
  on public.community_posts;
create policy "Users can delete their community posts"
  on public.community_posts
  for delete
  using (auth.uid() = user_id);

drop policy if exists "Authenticated users can read community comments"
  on public.community_comments;
create policy "Authenticated users can read community comments"
  on public.community_comments
  for select
  using (auth.role() = 'authenticated');

drop policy if exists "Users can create their community comments"
  on public.community_comments;
create policy "Users can create their community comments"
  on public.community_comments
  for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their community comments"
  on public.community_comments;
create policy "Users can delete their community comments"
  on public.community_comments
  for delete
  using (auth.uid() = user_id);

drop policy if exists "Authenticated users can read community reactions"
  on public.community_reactions;
create policy "Authenticated users can read community reactions"
  on public.community_reactions
  for select
  using (auth.role() = 'authenticated');

drop policy if exists "Users can create their community reactions"
  on public.community_reactions;
create policy "Users can create their community reactions"
  on public.community_reactions
  for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their community reactions"
  on public.community_reactions;
create policy "Users can delete their community reactions"
  on public.community_reactions
  for delete
  using (auth.uid() = user_id);

drop policy if exists "Authenticated users can read active community stories"
  on public.community_stories;
create policy "Authenticated users can read active community stories"
  on public.community_stories
  for select
  using (
    auth.role() = 'authenticated'
    and expires_at > now()
  );

drop policy if exists "Users can create their community stories"
  on public.community_stories;
create policy "Users can create their community stories"
  on public.community_stories
  for insert
  with check (
    auth.uid() = user_id
    and expires_at > now()
    and expires_at <= now() + interval '24 hours' + interval '1 minute'
  );

drop policy if exists "Users can delete their community stories"
  on public.community_stories;
create policy "Users can delete their community stories"
  on public.community_stories
  for delete
  using (auth.uid() = user_id);

create or replace function public.set_community_posts_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_community_posts_updated_at
  on public.community_posts;
create trigger set_community_posts_updated_at
  before update on public.community_posts
  for each row
  execute function public.set_community_posts_updated_at();

create or replace function public.refresh_community_post_comment_count()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if tg_op = 'INSERT' then
    update public.community_posts
      set comment_count = comment_count + 1
      where id = new.post_id;
    return new;
  end if;

  update public.community_posts
    set comment_count = greatest(comment_count - 1, 0)
    where id = old.post_id;
  return old;
end;
$$;

drop trigger if exists refresh_community_post_comment_count_insert
  on public.community_comments;
create trigger refresh_community_post_comment_count_insert
  after insert on public.community_comments
  for each row
  execute function public.refresh_community_post_comment_count();

drop trigger if exists refresh_community_post_comment_count_delete
  on public.community_comments;
create trigger refresh_community_post_comment_count_delete
  after delete on public.community_comments
  for each row
  execute function public.refresh_community_post_comment_count();

create or replace function public.refresh_community_post_reaction_count()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if tg_op = 'INSERT' then
    update public.community_posts
      set reaction_count = reaction_count + 1
      where id = new.post_id;
    return new;
  end if;

  update public.community_posts
    set reaction_count = greatest(reaction_count - 1, 0)
    where id = old.post_id;
  return old;
end;
$$;

drop trigger if exists refresh_community_post_reaction_count_insert
  on public.community_reactions;
create trigger refresh_community_post_reaction_count_insert
  after insert on public.community_reactions
  for each row
  execute function public.refresh_community_post_reaction_count();

drop trigger if exists refresh_community_post_reaction_count_delete
  on public.community_reactions;
create trigger refresh_community_post_reaction_count_delete
  after delete on public.community_reactions
  for each row
  execute function public.refresh_community_post_reaction_count();

create or replace function public.delete_expired_community_stories()
returns void
language plpgsql
security definer
set search_path = public, storage
as $$
declare
  expired_paths text[];
begin
  select coalesce(array_agg(image_path), array[]::text[])
    into expired_paths
    from public.community_stories
    where expires_at <= now()
      and image_path <> '';

  if array_length(expired_paths, 1) is not null then
    delete from storage.objects
      where bucket_id = 'community-stories'
        and name = any(expired_paths);
  end if;

  delete from public.community_stories
    where expires_at <= now();
end;
$$;

create extension if not exists pg_cron with schema extensions;

select cron.schedule(
  'delete-expired-community-stories',
  '*/15 * * * *',
  $$select public.delete_expired_community_stories();$$
)
where not exists (
  select 1
    from cron.job
    where jobname = 'delete-expired-community-stories'
);

drop policy if exists "Authenticated users can view community post images"
  on storage.objects;
create policy "Authenticated users can view community post images"
  on storage.objects
  for select
  using (
    bucket_id = 'community-posts'
    and auth.role() = 'authenticated'
  );

drop policy if exists "Users can upload their community post images"
  on storage.objects;
create policy "Users can upload their community post images"
  on storage.objects
  for insert
  with check (
    bucket_id = 'community-posts'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "Users can update their community post images"
  on storage.objects;
create policy "Users can update their community post images"
  on storage.objects
  for update
  using (
    bucket_id = 'community-posts'
    and (storage.foldername(name))[1] = auth.uid()::text
  )
  with check (
    bucket_id = 'community-posts'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "Users can delete their community post images"
  on storage.objects;
create policy "Users can delete their community post images"
  on storage.objects
  for delete
  using (
    bucket_id = 'community-posts'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "Authenticated users can view community story images"
  on storage.objects;
create policy "Authenticated users can view community story images"
  on storage.objects
  for select
  using (
    bucket_id = 'community-stories'
    and auth.role() = 'authenticated'
  );

drop policy if exists "Users can upload their community story images"
  on storage.objects;
create policy "Users can upload their community story images"
  on storage.objects
  for insert
  with check (
    bucket_id = 'community-stories'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "Users can delete their community story images"
  on storage.objects;
create policy "Users can delete their community story images"
  on storage.objects
  for delete
  using (
    bucket_id = 'community-stories'
    and (storage.foldername(name))[1] = auth.uid()::text
  );
