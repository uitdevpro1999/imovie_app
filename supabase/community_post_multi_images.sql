alter table public.community_posts
  add column if not exists image_urls jsonb not null default '[]'::jsonb;

update public.community_posts
set image_urls = jsonb_build_array(image_url)
where image_url <> ''
  and image_urls = '[]'::jsonb;

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'community_posts_image_urls_max_5'
  ) then
    alter table public.community_posts
      add constraint community_posts_image_urls_max_5
      check (
        jsonb_typeof(image_urls) = 'array'
        and jsonb_array_length(image_urls) <= 5
      );
  end if;
end $$;
