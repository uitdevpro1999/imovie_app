insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true)
on conflict (id) do update set public = excluded.public;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  full_name text not null,
  phone text,
  avatar_url text not null,
  cover_url text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles
  add column if not exists cover_url text;

update public.profiles
set cover_url = ''
where cover_url is null;

alter table public.profiles
  alter column cover_url set default '',
  alter column cover_url set not null;

alter table public.profiles enable row level security;

drop policy if exists "Users can view own profile" on public.profiles;

create policy "Users can view own profile"
on public.profiles
for select
using (auth.uid() = id);

drop policy if exists "Users can update own profile" on public.profiles;

create policy "Users can update own profile"
on public.profiles
for update
using (auth.uid() = id)
with check (auth.uid() = id);

drop policy if exists "Profile images are readable by authenticated users"
on storage.objects;

create policy "Profile images are readable by authenticated users"
on storage.objects
for select
to authenticated
using (bucket_id = 'avatars');

drop policy if exists "Users can upload their profile images"
on storage.objects;

create policy "Users can upload their profile images"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

drop policy if exists "Users can update their profile images"
on storage.objects;

create policy "Users can update their profile images"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
)
with check (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

drop policy if exists "Users can delete their profile images"
on storage.objects;

create policy "Users can delete their profile images"
on storage.objects
for delete
to authenticated
using (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists profiles_set_updated_at on public.profiles;

create trigger profiles_set_updated_at
before update on public.profiles
for each row
execute function public.set_updated_at();

create or replace function public.create_default_profile()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  email_name text;
begin
  email_name := split_part(new.email, '@', 1);

  insert into public.profiles (
    id,
    email,
    full_name,
    phone,
    avatar_url,
    cover_url
  )
  values (
    new.id,
    new.email,
    'user_' || email_name,
    coalesce(new.raw_user_meta_data ->> 'phone', null),
    'https://api.dicebear.com/9.x/initials/svg?seed=' || email_name,
    ''
  );

  return new;
end;
$$;

drop trigger if exists create_default_profile_after_signup on auth.users;

create trigger create_default_profile_after_signup
after insert on auth.users
for each row
execute function public.create_default_profile();
