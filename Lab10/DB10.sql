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

DROP FUNCTION IF EXISTS get_sport_type_id;
CREATE FUNCTION get_sport_type_id (sport_type_name varchar(32))
RETURNS int DETERMINISTIC
RETURN (SELECT sport_type.id FROM sport_type WHERE sport_type.name LIKE sport_type_name);

DROP FUNCTION IF EXISTS get_location_id;
CREATE FUNCTION get_location_id (location_name varchar(32))
RETURNS int DETERMINISTIC
RETURN (SELECT location.id FROM location WHERE location.name LIKE location_name);

DELIMITER $$
DROP FUNCTION IF EXISTS check_for_sport_type;
CREATE FUNCTION check_for_sport_type(location_name varchar(32), sport_type_name varchar(32))
RETURNS boolean DETERMINISTIC
	BEGIN
	DECLARE location_id int;
    DECLARE sport_type_id int;
	SET location_id = (SELECT get_location_id(location_name));
	SET sport_type_id = (SELECT get_sport_type_id (sport_type_name));
	RETURN (SELECT COUNT(*) as count 
			FROM location_sport_type 
            WHERE location_sport_type.location_id = location_id 
			  AND location_sport_type.sport_type_id = sport_type_id) > 0;
	END;
$$
DELIMITER ;                                         

SELECT check_for_sport_type('Aquapark', 'Running');

DELIMITER $$
DROP PROCEDURE IF EXISTS my_procedure;
CREATE PROCEDURE my_procedure()
BEGIN 
	CREATE TABLE IF NOT EXISTS proc_table (
		sport_type_name varchar(32),
        amount int
	);
    TRUNCATE proc_table;
    INSERT INTO proc_table SELECT sport_type.name AS sport_type_name, COUNT(*) AS amount
						   FROM sport_type LEFT JOIN location_sport_type ON
                           sport_type.id = location_sport_type.sport_type_id
                           GROUP BY sport_type_name;
END		
$$
DELIMITER ;

CALL my_procedure();
SELECT * FROM proc_table;