-- Pilot hotel: Hostal Nicolás de Ovando Boutique (Zona Colonial, Santo Domingo)
insert into public.concierge_tenants (tenant_id, hotel_name, languages, whatsapp_number, facts, rooms, direct_booking, availability_mode)
values (
  'hotel_zona_colonial_01',
  'Hostal Nicolás de Ovando Boutique',
  '{es,en}',
  '+18095550142',
  '{"address":"Calle Las Damas 52, Zona Colonial, Santo Domingo","checkin":"15:00","checkout":"12:00","parking":"Free street permit + paid lot 2 blocks away (RD$300/night)","wifi":"Free fiber wifi in all rooms and patio. Network: Ovando-Guest","pets":"Small pets allowed, no fee. Notify in advance.","amenities":["courtyard pool","rooftop terrace","air conditioning","daily breakfast","24h reception","airport pickup on request"],"breakfast":"Included. Dominican + continental, 7:30-10:30 on the courtyard.","transport":"10 min walk to Catedral Primada. Taxi to SDQ airport ~RD$1800, 35 min.","late_arrival_policy":"24h reception. Tell us your flight and we hold the room, no penalty."}'::jsonb,
  '[{"type":"Standard Queen","base_rate_usd":48,"max_guests":2},{"type":"Colonial Suite","base_rate_usd":72,"max_guests":3},{"type":"Family Room","base_rate_usd":95,"max_guests":4}]'::jsonb,
  '{"book_direct_discount_pct":12,"deposit_required":false,"front_desk_notify":"+18095550142"}'::jsonb,
  'manual'
)
on conflict (tenant_id) do update set facts = excluded.facts, rooms = excluded.rooms;
