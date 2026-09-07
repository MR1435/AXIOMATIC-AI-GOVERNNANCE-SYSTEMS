PRAGMA foreign_keys = ON;

-- Core geography hierarchy
INSERT OR IGNORE INTO geographies (id,type,name,state_code,county_name,city_name,zip_code,parent_id,metadata_json) VALUES
('geo-tn','state','Tennessee','TN',NULL,NULL,NULL,NULL,'{"scope":"statewide"}'),
('geo-shelby-tn','county','Shelby County','TN','Shelby',NULL,NULL,'geo-tn','{"scope":"county"}'),
('geo-memphis-tn','city','Memphis','TN','Shelby','Memphis',NULL,'geo-shelby-tn','{"scope":"citywide"}'),
('geo-38127','zip','38127','TN','Shelby','Memphis','38127','geo-memphis-tn','{"scope":"zip","seed_status":"baseline"}');

-- Canonical system-baseline records used only to validate routing.
-- These remain unpublished until replaced or supplemented with verified source-backed civic records.
INSERT OR IGNORE INTO records (
  id,record_type,title,summary,verification_status,geography_scope,canonical_json
) VALUES
('rec-38127-community-baseline','system-baseline','38127 Community Connects baseline','Internal routing baseline for neighborhood and local information in Memphis ZIP 38127.','unverified','zip','{"seed":true,"public_record":false,"purpose":"routing-test"}'),
('rec-38127-acr-baseline','system-baseline','38127 ACR baseline','Internal routing baseline for government and institutional information affecting Memphis ZIP 38127.','unverified','zip','{"seed":true,"public_record":false,"purpose":"routing-test"}'),
('rec-38127-justice-baseline','system-baseline','38127 Justice Sentinel baseline','Internal routing baseline for justice-accountability information associated with Memphis ZIP 38127.','unverified','zip','{"seed":true,"public_record":false,"purpose":"routing-test"}');

INSERT OR IGNORE INTO record_geographies (record_id,geography_id) VALUES
('rec-38127-community-baseline','geo-38127'),
('rec-38127-acr-baseline','geo-38127'),
('rec-38127-justice-baseline','geo-38127');

INSERT OR IGNORE INTO module_publications (
  record_id,module,headline,contextual_summary,category,prominence,published
) VALUES
('rec-38127-community-baseline','community','38127 Community baseline','Internal test record for Community Connects routing.','system-baseline',0,0),
('rec-38127-acr-baseline','acr','38127 ACR baseline','Internal test record for ACR routing.','system-baseline',0,0),
('rec-38127-justice-baseline','justice','38127 Justice baseline','Internal test record for Justice Sentinel routing.','system-baseline',0,0);

-- Default system watch targets for first geography; no user subscription is created here.
INSERT OR IGNORE INTO entities (id,entity_type,name,slug,description,metadata_json) VALUES
('entity-geo-38127','geography-context','Memphis ZIP 38127','memphis-38127','Baseline geography entity for the first Axiomatic Civic Intelligence launch area.','{"state":"TN","county":"Shelby","city":"Memphis","zip":"38127"}');
