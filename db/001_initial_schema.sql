-- Borrador para revisión, NO ejecutar en producción sin revisión de seguridad
create extension if not exists vector;
create table if not exists public.indicators (id uuid primary key default gen_random_uuid(), code text not null unique, display_name text not null, canonical_unit text, is_calculated boolean not null default false);
create table if not exists public.observations (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 indicator_id uuid not null references public.indicators(id),
 observed_at timestamptz not null, value numeric not null, unit text not null,
 origin text not null check(origin in ('laboratory','wearable','calculated','manual')),
 status text not null default 'pending_review' check(status in ('pending_review','approved','rejected')),
 source_document_id uuid, created_at timestamptz not null default now()
);
create table if not exists public.evidence_sources (id uuid primary key default gen_random_uuid(),title text not null,source_url text,doi text,version text,status text not null default 'candidate' check(status in ('candidate','under_review','approved','superseded')), reviewed_at timestamptz,created_at timestamptz not null default now());
create table if not exists public.evidence_chunks (id uuid primary key default gen_random_uuid(),source_id uuid not null references public.evidence_sources(id) on delete cascade,section text,page_number integer,content text not null,embedding vector(1536));
create table if not exists public.import_jobs (id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,object_path text not null,kind text not null check(kind in ('lab_pdf','whoop_export')),status text not null default 'queued',created_at timestamptz not null default now());
alter table public.indicators enable row level security;
alter table public.observations enable row level security;
alter table public.evidence_sources enable row level security;
alter table public.evidence_chunks enable row level security;
alter table public.import_jobs enable row level security;
create policy observations_own_select on public.observations for select to authenticated using((select auth.uid())=user_id);
create policy imports_own_select on public.import_jobs for select to authenticated using((select auth.uid())=user_id);
-- No insert/update policies: deny until secure server ingestion is implemented.