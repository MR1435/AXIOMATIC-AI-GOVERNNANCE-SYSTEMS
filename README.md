# Axiomatic Civic Intelligence

Unified civic-intelligence platform combining three distinct branded lenses over one canonical public-record layer:

- **The Community Connects™** — neighborhood intelligence
- **Axiomatic Community Report (ACR)™** — government intelligence
- **Axiomatic Justice Sentinel™** — justice accountability intelligence

## Governing architecture

**One record, many views.** Never duplicate a source record merely because it belongs in more than one module or geography.

A canonical record may be published to any combination of:

- Community Connects
- ACR
- Justice Sentinel

Each publication can have its own headline, summary, category and prominence while preserving the same underlying source record.

## Geography model

Every applicable record is scoped through the hierarchy:

United States → State → County → City/Municipality → ZIP → Property/Address

Supported display scopes:

- Statewide
- County
- Citywide
- ZIP-specific
- Property-specific
- Multi-geography

Inheritance rule: broader records should surface in relevant lower-level views without cloning the record. Example: a Memphis citywide ordinance can appear under every applicable Memphis ZIP filter while remaining one canonical record.

## Public navigation

- Home
- My Area
- Community
- Government
- Justice
- Records
- Alerts

A persistent location context controls the platform view, e.g. `Memphis, TN 38127`.

## Shared entity graph

Core entity classes should include people, agencies, government bodies, properties, ZIP codes, projects, permits, contracts, ordinances, budget items, campaign contributions, courts, cases, judges, attorneys, prosecutors, law-enforcement personnel/agencies, complaints, disciplinary actions, meetings and source documents.

Relations connect entities to canonical records and to one another.

## Module missions

### The Community Connects
Core question: **What is happening around me?**

Neighborhood reports, public resources, projects, infrastructure, hearings, representatives, safety and public-service information.

### ACR
Core question: **What is government doing?**

Budgets, contracts, ordinances, planning, public spending, school boards, institutional activity, conflicts and accountability reporting.

### Axiomatic Justice Sentinel
Core question: **Who is exercising legal authority, and what does the record show?**

Judges, prosecutors, attorneys, law enforcement, courts, complaints, disciplinary records, discovery issues and court-delay/calendar metrics.

## Cloudflare deployment

This repository is structured as a Cloudflare Worker using Wrangler.

```bash
npm install
npm run dev
npm run deploy
```

### D1 next step

Create the database, apply `schema.sql`, then uncomment and populate the D1 binding in `wrangler.toml`.

Suggested database name:

`axiomatic-civic-intelligence`

## Phase 1 build sequence

1. Platform shell and module navigation — scaffolded.
2. Canonical D1 schema — scaffolded.
3. Geography selector and inheritance queries.
4. Unified entity/record search.
5. Admin Intelligence Desk: ingest once, classify, verify, publish to modules.
6. Community Connects migration/import.
7. ACR record import.
8. Justice Sentinel profile ingestion.
9. Watchlists and alert delivery.
10. Existing-brand domain routing into module landing pages.

## Non-negotiable data rules

- Preserve source provenance and URLs.
- Clearly distinguish allegations, complaints, motions, findings, dispositions and sanctions.
- Never convert a citizen allegation into a verified institutional finding.
- Keep module-specific presentation separate from canonical facts.
- Use geographic inheritance instead of record duplication.
- Preserve the three product identities inside the unified platform.
