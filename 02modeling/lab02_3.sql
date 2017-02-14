--Jesse Hulse lab02 exercise 2.4

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP SEQUENCE movie_id_sequence;

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
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

--create the sequence to index the movie table
CREATE SEQUENCE movie_id_sequence START WITH 1;

INSERT INTO Movie VALUES (movie_id_sequence.NEXTVAL,'Star Wars',1977,8.9);
INSERT INTO Movie VALUES (movie_id_sequence.NEXTVAL,'Blade Runner',1982,8.6);
INSERT INTO Movie VALUES (movie_id_sequence.NEXTVAL,'Jurassic Park',1995,7.6);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');

--a: Would you need an additional sequence for the performer relation primary key values? Why or why not?
-- It would not be required to create a new sequence. One could use the movie_id_sequqnce.CURRVAL as folows
--CREATE SEQUENCE movie_id_sequence START WITH 1;
--INSERT INTO Movie VALUES (movie_id_sequence.NEXTVAL,'Star Wars',1977,8.9);
--INSERT INTO Performer VALUES (movie_id_sequence.CURRVAL,'Harrison Ford');
--INSERT INTO Movie VALUES (movie_id_sequence.NEXTVAL,'Blade Runner',1982,8.6);
--INSERT INTO Performer VALUES (movie_id_sequence.CURRVAL,'Rutger Hauer');
--INSERT INTO Movie VALUES (movie_id_sequence.NEXTVAL,'Jurassic Park',1995,7.6);
--INSERT INTO Performer VALUES (movie_id_sequence.CURRVAL,'The Mighty Chewbacca');
--INSERT INTO Performer VALUES (movie_id_sequence.NEXTVAL,'Rachael');

--b:Do you see any problems with using sequences in a DDL command file to construct the full movies database?
--One disadvanage is that it might take longer for the DDL command file to execute because of the additional
--overhead of calculating the sequence's value.
