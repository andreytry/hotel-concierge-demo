# Direct Booking Concierge — Hotel Vertical (DR)

A WhatsApp + web AI concierge for small independent hotels in Santo Domingo. Answers
guest questions 24/7 in ES/EN and converts inquiries into **direct** bookings, recovering
revenue lost to Booking.com / Expedia commission.

**Live demo:** https://andreytry.github.io/hotel-concierge-demo/

## Architecture
```
Guest (web widget or WhatsApp)
        │
        ▼
  n8n webhook  ──►  Supabase tenant lookup  ──►  GPT-4o (structured output)
        │                                              │
        ├── reply to guest ◄───────────────────────────┘
        ├── log every turn        → concierge_message_log
        └── if booking_ready:     → concierge_bookings (pending)
                                  → Twilio front-desk notify
```

## Stack
- **Supabase** `zkylrolpuwybsksspblj` — `concierge_*` tables (`db/schema.sql`, `db/seed_pilot.sql`)
- **n8n Cloud** — workflow `iTt8wDnZn2MR7KRI`, webhook `/webhook/concierge` (`n8n/workflow.json`)
- **GPT-4o** — concierge brain, ES/EN, structured JSON (`prompts/system-prompt.md`)
- **Twilio** — WhatsApp channel + front-desk notify
- **GitHub Pages** — the static landing page (`index.html`)

## Repo layout
| Path | What |
| --- | --- |
| `index.html` | Landing page + live chat widget (calls the n8n webhook) |
| `db/schema.sql` | Supabase tables |
| `db/seed_pilot.sql` | Pilot hotel config row |
| `n8n/workflow.json` | Deployed workflow topology (human-readable) |
| `prompts/system-prompt.md` | Concierge system prompt + output schema |

## Test results (2026-06-21)
| Case | Result |
| --- | --- |
| FAQ — parking + check-in (EN) | PASS — facts pulled from config |
| Booking — Colonial Suite, 3 nights, 2 guests | PASS — $72×3×0.88 = $190.08, row pending |
| Conversation logging | PASS — every turn logged |
| Front-desk WhatsApp notify | PENDING — needs Meta sender approval (non-blocking) |

## Known open items
- Meta/WhatsApp Business sender approval (for the WhatsApp channel + front-desk notify)
- Hetzner production host (SSH key not held)
- Rotate the GitHub PAT used to deploy

Built per the spec: *Direct Booking Concierge — Hotel Vertical Spec (DR)*.
Method documented in Confluence: **Software Factory — Universal POC Playbook**.
