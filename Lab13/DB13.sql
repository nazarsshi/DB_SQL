USE nulp_db;

DROP TABLE IF EXISTS location, sport_type, location_sport_type;
 
CREATE TABLE IF NOT EXISTS location (
   id int NOT NULL AUTO_INCREMENT,
   name varchar(32) NOT NULL,
   PRIMARY KEY (id)
);
SHOW INDEX FROM location;

INSERT INTO location(name)
VALUES ('Aquapark'),
       ('YogaMaster'),
       ('Struyskiy Park');

TRUNCATE location;
CREATE UNIQUE INDEX uq_l_name ON location(name);
SHOW INDEX FROM location;

INSERT INTO location(name)
VALUES ('Aquapark'),
       ('YogaMaster'),
       ('Struyskiy Park');
       
CREATE TABLE IF NOT EXISTS sport_type (
   id int NOT NULL AUTO_INCREMENT,
   name varchar(32) NOT NULL,
   PRIMARY KEY (id)
);
SHOW INDEX FROM sport_type;

INSERT INTO sport_type(name)
VALUES ('Running'),
       ('Swimming'),
       ('Football'),
       ('Yoga'),
       ('Basketball'),
       ('Voleyball'),
       ('Tennis'),
       ('Racing'),
       ('Baseball'),
       ('1'),
       ('2'),
       ('3'),
       ('4'),
       ('5'),
       ('6'),
       ('7'),
       ('8'),
       ('9'),
       ('10'),
       ('11'),
       ('12'),
       ('13');
       
CREATE INDEX sp_name ON sport_type(name);
TRUNCATE sport_type;
SHOW INDEX FROM sport_type;

INSERT INTO sport_type(name)
VALUES ('Running'),
       ('Swimming'),
       ('Football'),
       ('Yoga'),
       ('Basketball'),
       ('Voleyball'),
       ('Tennis'),
       ('Racing'),
       ('Baseball'),
       ('1'),
       ('2'),
       ('3'),
       ('4'),
       ('5'),
       ('6'),
       ('7'),
       ('8'),
       ('9'),
       ('10'),
       ('11'),
       ('12'),
       ('13');
       
CREATE TABLE IF NOT EXISTS location_sport_type (
   location_id int NOT NULL,
   sport_type_id int NOT NULL,

   PRIMARY KEY (location_id, sport_type_id),

   CONSTRAINT fk_location_sport_type_location 
	FOREIGN KEY (location_id) 
		REFERENCES location (id),

   CONSTRAINT fk_location_sport_type_sport_type 
	FOREIGN KEY (sport_type_id) 
		REFERENCES sport_type (id)
);

INSERT INTO location_sport_type(location_id, sport_type_id) 
VALUES (1,1),
	   (1,2),
       (1,4),
       (2,1),
       (2,3),
       (3,4);

SHOW INDEX FROM location_sport_type;

EXPLAIN SELECT sport_type.name as spn, COUNT(*) FROM sport_type 
LEFT JOIN location_sport_type ON location_sport_type.sport_type_id = sport_type.id
GROUP BY spn;

ANALYZE TABLE sport_type;