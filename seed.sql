PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO geographies (id,type,name,state_code,county_name,city_name,zip_code,parent_id) VALUES
('geo-tn','state','Tennessee','TN',NULL,NULL,NULL,NULL),
('geo-shelby-tn','county','Shelby County','TN','Shelby',NULL,NULL,'geo-tn'),
('geo-memphis-tn','city','Memphis','TN','Shelby','Memphis',NULL,'geo-shelby-tn'),
('geo-38127','zip','38127','TN','Shelby','Memphis','38127','geo-memphis-tn');
