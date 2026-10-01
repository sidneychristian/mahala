# MAHALA — Rifas e Prémios

## 1. Supabase (base de dados)
1. Cria um projecto em supabase.com.
2. SQL Editor → New query → cola o conteúdo de `supabase.sql` → Run. (Cria as tabelas `raffles` e `tickets` e a pasta de imagens `premios`.)
3. Authentication → Users → Add user: cria o teu email e senha de admin.
4. Authentication → desactiva o registo de novos utilizadores (senão qualquer pessoa cria conta e entra no admin).
5. Project Settings → API: copia o **Project URL** e a chave **publishable** e cola-os em `config.js`.

## 2. Vercel (publicar)
Projecto estático, sem build. Opção A: sobe a pasta para um repositório GitHub → vercel.com → Add New → Project → Import → Deploy.
Opção B: na pasta, corre `npx vercel`.
O site fica em `/` e o admin em `/admin`.

## 3. Uso
- Admin → Rifas: nome e foto do prémio, preço, início e duração. "Terminar agora", "Mudar duração", "Sortear".
- Admin → Participantes: confirma o pagamento SÓ depois de veres o dinheiro no Emola/BCI. O botão WhatsApp envia a mensagem pronta (lembrete, pago, reembolso, vencedor).
- Números de pagamento e WhatsApp: `config.js`. Textos das mensagens: `admin.html` (bloco MSG) e `index.html`.
