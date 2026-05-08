create extension if not exists pgcrypto;

create table if not exists public.user_push_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  token text not null,
  platform text not null
    check (platform in ('android', 'ios', 'web', 'unknown')),
  device_name text not null default '',
  locale_code text not null default '',
  is_active boolean not null default true,
  last_seen_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint user_push_tokens_token_key unique (token)
);

create index if not exists user_push_tokens_user_id_idx
  on public.user_push_tokens (user_id, is_active, updated_at desc);

alter table public.user_push_tokens enable row level security;

drop policy if exists "Users can read their push tokens"
  on public.user_push_tokens;
create policy "Users can read their push tokens"
  on public.user_push_tokens
  for select
  using (auth.uid() = user_id);

drop policy if exists "Users can insert their push tokens"
  on public.user_push_tokens;
create policy "Users can insert their push tokens"
  on public.user_push_tokens
  for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their push tokens"
  on public.user_push_tokens;
create policy "Users can update their push tokens"
  on public.user_push_tokens
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their push tokens"
  on public.user_push_tokens;
create policy "Users can delete their push tokens"
  on public.user_push_tokens
  for delete
  using (auth.uid() = user_id);

create or replace function public.set_user_push_tokens_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_user_push_tokens_updated_at_trigger
  on public.user_push_tokens;
create trigger set_user_push_tokens_updated_at_trigger
  before update on public.user_push_tokens
  for each row
  execute procedure public.set_user_push_tokens_updated_at();

create or replace function public.upsert_user_push_token(
  target_token text,
  target_platform text,
  target_device_name text default '',
  target_locale_code text default ''
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'Unauthorized';
  end if;

  insert into public.user_push_tokens (
    user_id,
    token,
    platform,
    device_name,
    locale_code,
    is_active,
    last_seen_at
  )
  values (
    auth.uid(),
    trim(target_token),
    trim(target_platform),
    trim(target_device_name),
    trim(target_locale_code),
    true,
    now()
  )
  on conflict (token)
  do update set
    user_id = auth.uid(),
    platform = excluded.platform,
    device_name = excluded.device_name,
    locale_code = excluded.locale_code,
    is_active = true,
    last_seen_at = now(),
    updated_at = now();
end;
$$;

grant execute on function public.upsert_user_push_token(text, text, text, text)
  to authenticated;
