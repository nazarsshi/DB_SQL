USE nulp_db;

DROP TABLE IF EXISTS location, sport_type, location_sport_type;
 
CREATE TABLE IF NOT EXISTS location (
   id int NOT NULL AUTO_INCREMENT,
   name varchar(32) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE KEY uq_location_name (name)
);

INSERT INTO location(name)
values ('Aquapark'),
       ('World of football'),
       ('YogaMaster'),
       ('Struyskiy Park');
       
CREATE TABLE IF NOT EXISTS sport_type (
   id int NOT NULL AUTO_INCREMENT,
   name varchar(32) NOT NULL,
   PRIMARY KEY (id)
);

INSERT INTO sport_type(name)
VALUES ('Running'),
       ('Swimming'),
       ('Football'),
       ('Yoga');
       
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
       (3,4),
       (4,1),
       (4,4);
 
 START TRANSACTION;
 CREATE TABLE IF NOT EXISTS transact_table( id int not null auto_increment primary key, transact_value varchar(20));
 ALTER TABLE transact_table MODIFY transact_value int;
 ROLLBACK;
 DESC transact_table;
 SHOW TABLES;
 
 TRUNCATE transact_table;
 START TRANSACTION;
 SAVEPOINT first_save;
 INSERT INTO transact_table(transact_value) VALUES (1),(2),(3),(4),(5);
 ROLLBACK TO first_save;
 SELECT * FROM transact_table;
 INSERT INTO transact_table(transact_value) VALUES (1),(2),(3),(4),(5);
 SAVEPOINT second_save;
 UPDATE transact_table SET transact_value = transact_value + (50 - transact_value);
 SELECT * FROM transact_table;
 ROLLBACK TO second_save;
 SELECT * FROM transact_table;
 COMMIT;