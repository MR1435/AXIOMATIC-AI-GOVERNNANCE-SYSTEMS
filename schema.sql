PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS geographies (
  id TEXT PRIMARY KEY,
  type TEXT NOT NULL CHECK (type IN ('state','county','city','zip','property')),
  name TEXT NOT NULL,
  state_code TEXT,
  county_name TEXT,
  city_name TEXT,
  zip_code TEXT,
  address TEXT,
  parent_id TEXT,
  metadata_json TEXT,
  FOREIGN KEY (parent_id) REFERENCES geographies(id)
);

CREATE TABLE IF NOT EXISTS entities (
  id TEXT PRIMARY KEY,
  entity_type TEXT NOT NULL,
  name TEXT NOT NULL,
  slug TEXT UNIQUE,
  description TEXT,
  metadata_json TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS records (
  id TEXT PRIMARY KEY,
  record_type TEXT NOT NULL,
  title TEXT NOT NULL,
  summary TEXT,
  source_url TEXT,
  source_agency TEXT,
  source_date TEXT,
  verification_status TEXT DEFAULT 'unverified' CHECK (verification_status IN ('unverified','partially-corroborated','verified-public-record','court-finding','disciplinary-finding','resolved','unable-to-verify')),
  geography_scope TEXT NOT NULL CHECK (geography_scope IN ('statewide','county','citywide','zip','property','multi')),
  canonical_json TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS record_geographies (
  record_id TEXT NOT NULL,
  geography_id TEXT NOT NULL,
  PRIMARY KEY (record_id, geography_id),
  FOREIGN KEY (record_id) REFERENCES records(id) ON DELETE CASCADE,
  FOREIGN KEY (geography_id) REFERENCES geographies(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS record_entities (
  record_id TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  relationship TEXT NOT NULL,
  PRIMARY KEY (record_id, entity_id, relationship),
  FOREIGN KEY (record_id) REFERENCES records(id) ON DELETE CASCADE,
  FOREIGN KEY (entity_id) REFERENCES entities(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS module_publications (
  record_id TEXT NOT NULL,
  module TEXT NOT NULL CHECK (module IN ('community','acr','justice')),
  headline TEXT,
  contextual_summary TEXT,
  category TEXT,
  prominence INTEGER DEFAULT 0,
  published INTEGER DEFAULT 1,
  published_at TEXT,
  PRIMARY KEY (record_id, module),
  FOREIGN KEY (record_id) REFERENCES records(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS profiles (
  id TEXT PRIMARY KEY,
  entity_id TEXT NOT NULL,
  profile_type TEXT NOT NULL CHECK (profile_type IN ('judge','prosecutor','attorney','law-enforcement','official','agency')),
  module TEXT NOT NULL DEFAULT 'justice' CHECK (module IN ('community','acr','justice')),
  geography_id TEXT,
  status TEXT DEFAULT 'active',
  summary TEXT,
  profile_json TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (entity_id) REFERENCES entities(id) ON DELETE CASCADE,
  FOREIGN KEY (geography_id) REFERENCES geographies(id)
);

CREATE TABLE IF NOT EXISTS attorney_governance_submissions (
  id TEXT PRIMARY KEY,
  attorney_name TEXT NOT NULL,
  firm TEXT,
  bar_number TEXT,
  state_code TEXT NOT NULL,
  county_name TEXT NOT NULL,
  city_name TEXT,
  zip_code TEXT,
  case_number TEXT,
  total_score INTEGER NOT NULL CHECK (total_score BETWEEN 0 AND 60),
  scores_json TEXT NOT NULL,
  notes TEXT,
  evidence TEXT,
  bar_status TEXT,
  bar_source TEXT,
  bar_verified_at TEXT,
  status TEXT NOT NULL DEFAULT 'citizen-submission-unverified',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS reports (
  id TEXT PRIMARY KEY,
  report_type TEXT NOT NULL CHECK (report_type IN ('daily','weekly','special')),
  title TEXT NOT NULL,
  period_start TEXT,
  period_end TEXT,
  geography_id TEXT,
  summary TEXT,
  body_json TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  published_at TEXT,
  FOREIGN KEY (geography_id) REFERENCES geographies(id)
);

CREATE TABLE IF NOT EXISTS report_destinations (
  report_id TEXT NOT NULL,
  destination_type TEXT NOT NULL CHECK (destination_type IN ('community','acr','justice','my-area','intelligence-inbox')),
  geography_id TEXT,
  published INTEGER DEFAULT 0,
  published_at TEXT,
  PRIMARY KEY (report_id, destination_type, geography_id),
  FOREIGN KEY (report_id) REFERENCES reports(id) ON DELETE CASCADE,
  FOREIGN KEY (geography_id) REFERENCES geographies(id)
);

CREATE TABLE IF NOT EXISTS intake_queue (
  id TEXT PRIMARY KEY,
  intake_type TEXT NOT NULL,
  title TEXT NOT NULL,
  source_url TEXT,
  source_text TEXT,
  proposed_record_type TEXT,
  proposed_geography_scope TEXT,
  proposed_modules_json TEXT,
  verification_status TEXT DEFAULT 'pending',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  reviewed_at TEXT
);

CREATE TABLE IF NOT EXISTS watchlists (
  id TEXT PRIMARY KEY,
  user_key TEXT NOT NULL,
  target_type TEXT NOT NULL,
  target_id TEXT NOT NULL,
  label TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_geo_zip ON geographies(zip_code);
CREATE INDEX IF NOT EXISTS idx_geo_state ON geographies(state_code);
CREATE INDEX IF NOT EXISTS idx_records_type ON records(record_type);
CREATE INDEX IF NOT EXISTS idx_records_verify ON records(verification_status);
CREATE INDEX IF NOT EXISTS idx_publications_module ON module_publications(module, published);
CREATE INDEX IF NOT EXISTS idx_profiles_type ON profiles(profile_type, module);
CREATE INDEX IF NOT EXISTS idx_attorney_governance_name ON attorney_governance_submissions(attorney_name, state_code);
CREATE INDEX IF NOT EXISTS idx_reports_type ON reports(report_type, published_at);
CREATE INDEX IF NOT EXISTS idx_intake_status ON intake_queue(verification_status, created_at);
