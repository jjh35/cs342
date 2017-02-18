
-- Starter code for lab 3.
-- Jesse Hulse
-- CS 342, Spring, 2017
-- kvlinden
drop table Team_Membership;
drop table Request;
drop table Person;
drop table HouseHold;
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
	Household_ID NOT NULL,
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	mentor integer,
	FOREIGN KEY (mentor) REFERENCES Person(ID),
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

create table Request(
	Responder integer NOT NULL,
	Requestor integer NOT NULL,
	Date_of_request date NOT NULL,
	Description varchar(32),
	Access_level varchar(32),
	Response varchar(32),
	FOREIGN KEY (Responder) references Person(ID),
	FOREIGN KEY (Requestor) references HouseHold(ID)
	);



INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden', 0,'m', NULL);
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden', 0,'m', NULL); 

--add sample data into the three new tables

INSERT INTO TEAM VALUES (0, 'worship', '9:00AM', 'Church' );

INSERT INTO Team_Membership VALUES(0,1,0, 'leader');

INSERT INTO Request VALUES(1,0, '01-JAN-02', 'prayer request', 'Deacons',  'support');