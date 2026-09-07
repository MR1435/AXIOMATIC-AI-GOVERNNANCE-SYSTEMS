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
  status TEXT DEFAULT 'verified',
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
  PRIMARY KEY (record_id, module),
  FOREIGN KEY (record_id) REFERENCES records(id) ON DELETE CASCADE
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
CREATE INDEX IF NOT EXISTS idx_publications_module ON module_publications(module, published);
