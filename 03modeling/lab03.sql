
-- Starter code for lab 3.
-- Jesse Hulse
-- CS 342, Spring, 2017
-- kvlinden

drop table Person_HouseHold;
drop table Team_Membership;
drop table HouseHold;
drop table Person;
drop table Team;


create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	mentor integer,
	FOREIGN KEY (mentor) REFERENCES Person(ID)
	);
--the table for saving person-household info
create table Person_HouseHold (
	ID integer PRIMARY KEY,
	Person_ID integer NOT NULL,
	HouseHold_ID integer NOT NULL,
	role varchar(25),
	FOREIGN KEY (Person_ID) REFERENCES Person(ID) ON DELETE CASCADE, --if person is deleted, then deleted the entry
	FOREIGN KEY (HouseHold_ID) REFERENCES HouseHold(ID) ON DELETE CASCADE --if the household is deleted, then person should not longer be in it
	);
--a table for listing teams
create table team(
	ID integer PRIMARY KEY,
	Mandate varchar(32),
	Time_of_day varchar(32),
	Place varchar(32)
	);
--saves which teams a person is part of
create table Team_Membership(
	ID integer PRIMARY KEY,
	Person_ID integer NOT NULL,
	Team_ID integer NOT NULL,
	role varchar(16),
	FOREIGN KEY (Person_ID) REFERENCES Person(ID),
	FOREIGN KEY (Team_ID) REFERENCES Team(ID)
	);


INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m', NULL);
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m', NULL); 

--add sample data into the three new tables
INSERT INTO Person_HouseHold VALUES (1, 1,0,'mother');

INSERT INTO TEAM VALUES (0, 'worship', '9:00AM', 'Church' );

INSERT INTO Team_Membership VALUES(0,1,0, 'leader');