--Jesse Hulse, lab02, Exercise 2.3 

--Can you modify the movies database to support the enumerated status type using the relational 
--model itself rather than hard-coding the values in a CHECK constraint?
--Yes, just add a table called PERFORMER_STATUS with the status names and reference this table instead 
--of hard-coding the values. The value of this are: 1. if someone wants to change the name of a status, then
--they just need to change  the the value in the table instead of changing all the hard coded values. Also, using 
-- a seperate table will cutdown on repeated data. 
--Disadvantages: 1. One will have to use a join if they want the name of the status instead of the numeric id.
--2. a numeric key may be hard to remember. In this case it may be easier to not use a numeric key and just use
--the string as the key, but then one loses the advantage of easy updating. 


-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP TABLE PERFORMER_STATUS;


CREATE TABLE PERFORMER_STATUS(
Id integer,
casting_status varchar(6),
PRIMARY KEY(Id)
);

-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	casting_status integer,
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	FOREIGN KEY (casting_status) REFERENCES PERFORMER_STATUS(Id) ON DELETE SET NULL
	);


	-- Load sample data
INSERT INTO PERFORMER_STATUS VALUES(1,'star');
INSERT INTO PERFORMER_STATUS VALUES(2,'costar');
INSERT INTO PERFORMER_STATUS VALUES(3,'extra');

INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,1);
INSERT INTO Casting VALUES (1,3,3);
INSERT INTO Casting VALUES (2,1,1);
INSERT INTO Casting VALUES (2,2,2);
INSERT INTO Casting VALUES (2,4,2);
