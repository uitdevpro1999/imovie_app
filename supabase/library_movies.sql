create extension if not exists pgcrypto;

create table if not exists public.library_movies (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  movie_id text not null,
  slug text not null,
  title text not null,
  original_title text not null default '',
  poster_url text not null default '',
  backdrop_url text not null default '',
  year integer not null default 0,
  type text not null default '',
  quality text not null default '',
  language text not null default '',
  runtime text not null default '',
  current_episode text not null default '',
  total_episodes text not null default '',
  rating numeric(4, 2) not null default 0,
  genres jsonb not null default '[]'::jsonb,
  countries jsonb not null default '[]'::jsonb,
  movie jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint library_movies_user_slug_unique unique (user_id, slug)
);

create index if not exists library_movies_user_created_at_idx
  on public.library_movies (user_id, created_at desc);

create index if not exists library_movies_user_slug_idx
  on public.library_movies (user_id, slug);

alter table public.library_movies enable row level security;

drop policy if exists "Users can read their library movies"
  on public.library_movies;
create policy "Users can read their library movies"
  on public.library_movies
  for select
  using (auth.uid() = user_id);

drop policy if exists "Users can insert their library movies"
  on public.library_movies;
create policy "Users can insert their library movies"
  on public.library_movies
  for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their library movies"
  on public.library_movies;
create policy "Users can update their library movies"
  on public.library_movies
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their library movies"
  on public.library_movies;
create policy "Users can delete their library movies"
  on public.library_movies
  for delete
  using (auth.uid() = user_id);

create or replace function public.set_library_movies_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_library_movies_updated_at
  on public.library_movies;
create trigger set_library_movies_updated_at
  before update on public.library_movies
  for each row
  execute function public.set_library_movies_updated_at();
