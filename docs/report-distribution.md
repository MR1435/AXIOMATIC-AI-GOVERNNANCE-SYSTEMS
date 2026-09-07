# Report Distribution Layer

## Objective
Generate each intelligence report once from canonical records, then route it to every applicable public destination and private delivery channel without duplicating source records.

## Cadence
- Daily Brief: rolling 24-hour changes and urgent items.
- Weekly Intelligence Review: seven-day synthesis, trends, unresolved items, and upcoming dates.

## Public destinations
Each report item carries module and geography tags.

### Module destinations
- `community` — The Community Connects
- `government` — Axiomatic Community Report (ACR)
- `justice` — Axiomatic Justice Sentinel

One item may route to multiple modules while retaining one canonical record ID.

### Geography destinations
- Statewide
- County
- City / municipality
- ZIP code(s)
- Property / address

Geographic inheritance applies: a Tennessee statewide record can surface in Tennessee-local dashboards; Memphis citywide records can surface across applicable Memphis ZIP views without duplicate records.

## Private destinations
- User email inbox
- Unified in-app Intelligence Inbox
- Watchlist-specific alert feeds

Future destinations may include SMS, push notifications, Slack, or partner feeds through the same routing interface.

## Daily Brief sections
1. Urgent / action needed
2. Community
3. Government / ACR
4. Justice Sentinel
5. Statewide changes
6. ZIP-specific changes
7. Upcoming hearings, deadlines, meetings, elections, filings, and public-comment periods
8. Source links and verification status

## Weekly Intelligence Review sections
1. Executive summary
2. Top developments by module
3. Top developments by geography
4. Trends and repeated entities
5. New relationships discovered between people, agencies, projects, properties, cases, contracts, permits, and complaints
6. Items requiring verification or follow-up
7. Upcoming seven- and thirty-day calendar
8. Watchlist changes

## Routing fields
Recommended report routing fields:

- `report_id`
- `report_type` (`daily`, `weekly`, `special`)
- `canonical_record_id`
- `module_targets[]`
- `geography_targets[]`
- `urgency`
- `verification_status`
- `publish_public`
- `send_email`
- `send_in_app`
- `watchlist_matches[]`
- `generated_at`
- `published_at`
- `delivery_status`

## Publishing rule
A report is a presentation object, not a duplicate civic record. Every report item must point back to its canonical record and source evidence.

## Responsive presentation
All report destinations must support mobile, tablet, and desktop layouts. Each report card should expose:
- module badge
- geography badge
- headline
- concise summary
- why it matters
- source / verification status
- canonical record link
- save / watch action

## Email delivery
Email should contain a concise responsive HTML digest with deep links back to the exact module + geography view. Critical items appear first. The full report remains available on-platform.
