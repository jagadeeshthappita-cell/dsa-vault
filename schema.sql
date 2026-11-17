-- Run once in Supabase: SQL Editor > New query
create table vault (
  user_id uuid primary key references auth.users on delete cascade,
  data jsonb not null,
  updated_at timestamptz default now()
);
alter table vault enable row level security;
create policy "own row only" on vault for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
