-- Cola tudo isto no Supabase: SQL Editor > New query > Run
create extension if not exists pgcrypto;

create table raffles (
  id uuid primary key default gen_random_uuid(),
  nome text not null,                       -- nome do prémio
  imagem_url text,                          -- foto do prémio
  preco numeric not null default 100,       -- preço por bilhete
  inicio timestamptz not null default now(),
  fim timestamptz not null,
  encerrada boolean not null default false, -- true = terminada pelo admin ou sorteada
  vencedor_id uuid,                         -- bilhete vencedor
  created_at timestamptz default now()
);

create table tickets (
  id uuid primary key default gen_random_uuid(),
  raffle_id uuid not null references raffles(id) on delete cascade,
  codigo text not null unique,              -- ex.: MH-7K2QX
  nome text not null,
  telefone text not null,
  qtd int not null check (qtd between 1 and 100),
  metodo text not null,
  estado text not null default 'pendente' check (estado in ('pendente','pago','reembolsado')),
  created_at timestamptz default now()
);

alter table raffles enable row level security;
alter table tickets enable row level security;

-- Público: só vê as rifas e só consegue registar um bilhete "pendente"
create policy "ver rifas" on raffles for select using (true);
create policy "registar bilhete" on tickets for insert to anon, authenticated with check (estado = 'pendente');
-- Admin (utilizador com login): faz tudo
create policy "admin rifas" on raffles for all to authenticated using (true) with check (true);
create policy "admin bilhetes" on tickets for all to authenticated using (true) with check (true);

-- Pasta de imagens dos prémios
insert into storage.buckets (id, name, public) values ('premios', 'premios', true) on conflict do nothing;
create policy "ver imagens" on storage.objects for select using (bucket_id = 'premios');
create policy "admin envia imagens" on storage.objects for insert to authenticated with check (bucket_id = 'premios');
create policy "admin apaga imagens" on storage.objects for delete to authenticated using (bucket_id = 'premios');
