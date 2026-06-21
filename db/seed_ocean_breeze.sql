-- Real hotel: Ocean Breeze Studios (Zona Colonial, Santo Domingo)
-- Scraped from sites.google.com/nox.company/ocean-breeze  (phone/WhatsApp 809-685-0193)
insert into public.concierge_tenants (tenant_id, hotel_name, languages, whatsapp_number, facts, rooms, direct_booking, availability_mode)
values (
  'ocean_breeze_studios','Ocean Breeze Studios','{es,en}','+18096850193',
  '{"address":"Calle Palo Hincado 202, Esq. Calle Canela, Zona Colonial, Santo Domingo 10208","reception":"Open 24/7","checkin":"Flexible — 24/7 reception, late check-in on request","parking":"No private parking on-site; paid private parking ~150m away","wifi":"Free WiFi in every studio and common areas","kitchen":"Every studio has a private kitchen","amenities":["free WiFi","air conditioning","private kitchen","private bathroom","TV with cable","balcony (select studios)","rooftop terrace","24/7 reception"],"location":"Heart of Zona Colonial, ~100m from Parque Independencia and El Conde; near Parque Colon and Plaza Espana","transport":"~25 min by car to Las Americas International Airport (SDQ)","contact":"Phone/WhatsApp (809) 685-0193 · oceanbreezestudios@gmail.com"}'::jsonb,
  '[{"type":"Basic Studio","base_rate_usd":39,"max_guests":2},{"type":"Deluxe Studio","base_rate_usd":45,"max_guests":2},{"type":"Luxe Studio","base_rate_usd":49,"max_guests":2}]'::jsonb,
  '{"book_direct_discount_pct":10,"deposit_required":false,"front_desk_notify":"+18096850193"}'::jsonb,
  'manual'
)
on conflict (tenant_id) do update set facts=excluded.facts, rooms=excluded.rooms, direct_booking=excluded.direct_booking;
