-- Direct Booking Concierge — Hotel Vertical
-- Supabase (project zkylrolpuwybsksspblj). Tables live in public with a concierge_ prefix
-- so PostgREST (the n8n Supabase node) can reach them without custom-schema exposure.

create table if not exists public.concierge_tenants (
  tenant_id          text primary key,
  hotel_name         text not null,
  languages          text[] not null default '{es,en}',
  whatsapp_number    text unique,
  facts              jsonb not null default '{}'::jsonb,
  rooms              jsonb not null default '[]'::jsonb,
  direct_booking     jsonb not null default '{}'::jsonb,
  availability_mode  text not null default 'manual',
  active             boolean not null default true,
  created_at         timestamptz not null default now()
);

create table if not exists public.concierge_bookings (
  id            uuid primary key default gen_random_uuid(),
  tenant_id     text not null references public.concierge_tenants(tenant_id) on delete cascade,
  guest_name    text,
  guest_contact text,
  channel       text not null default 'whatsapp',
  room_type     text,
  checkin       date,
  checkout      date,
  guests        int,
  quoted_usd    numeric(10,2),
  direct_discount_pct numeric(5,2) default 0,
  source        text default 'direct',
  status        text not null default 'pending',
  notes         text,
  created_at    timestamptz not null default now()
);

create table if not exists public.concierge_leads (
  id            uuid primary key default gen_random_uuid(),
  tenant_id     text not null references public.concierge_tenants(tenant_id) on delete cascade,
  guest_name    text,
  guest_contact text not null,
  language      text,
  last_intent   text,
  opted_in      boolean default true,
  created_at    timestamptz not null default now(),
  unique (tenant_id, guest_contact)
);

create table if not exists public.concierge_message_log (
  id            bigint generated always as identity primary key,
  tenant_id     text references public.concierge_tenants(tenant_id) on delete set null,
  channel       text,
  direction     text,
  guest_contact text,
  language      text,
  intent        text,
  model         text,
  message       text,
  created_at    timestamptz not null default now()
);

create index if not exists idx_cbookings_tenant_status on public.concierge_bookings(tenant_id, status);
create index if not exists idx_cleads_tenant on public.concierge_leads(tenant_id);
create index if not exists idx_cmsglog_tenant_time on public.concierge_message_log(tenant_id, created_at desc);
create index if not exists idx_ctenants_whatsapp on public.concierge_tenants(whatsapp_number);
