USE nulp_db;

DROP TABLE IF EXISTS location, sport_type, location_sport_type;
 
CREATE TABLE IF NOT EXISTS location (
   id int NOT NULL AUTO_INCREMENT,
   name varchar(45) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE KEY uq_location_name (name)
);
       
CREATE TABLE IF NOT EXISTS sport_type (
   id int NOT NULL AUTO_INCREMENT,
   name varchar(32) NOT NULL,
   PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS before_insert_trigger;
CREATE TRIGGER before_insert_trigger BEFORE INSERT 
ON location FOR EACH ROW
SET NEW.name = CONCAT(NEW.name, ' triggered');

DROP TRIGGER IF EXISTS after_insert_trigger;
CREATE TRIGGER after_insert_trigger AFTER INSERT 
ON location FOR EACH ROW
INSERT INTO sport_type(name) VALUES ('Value after location insert');
  
INSERT INTO location(name)
values ('Aquapark'),
       ('World of football'),
       ('YogaMaster'),
       ('Struyskiy Park');

INSERT INTO sport_type(name)
VALUES ('Running'),
       ('Swimming'),
       ('Football'),
       ('Yoga');

SELECT * FROM location;
SELECT * FROM sport_type;
       
CREATE TABLE IF NOT EXISTS location_sport_type (
   location_id int,
   sport_type_id int,
   
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
       (3,4),
       (4,1),
       (4,4);

DROP TRIGGER IF EXISTS before_delete_trigger;
CREATE TRIGGER before_delete_trigger BEFORE DELETE
ON location_sport_type FOR EACH ROW
UPDATE sport_type
SET sport_type.name = 'Deleted from transitive table' WHERE sport_type.id = OLD.sport_type_id;
 
DELETE FROM location_sport_type WHERE sport_type_id < 3;

SELECT * FROM sport_type;
SELECT * FROM location_sport_type;