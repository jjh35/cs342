--If I've read your answer correctly, you got the normalized schema: Person(ID, name, status, mentorId) Team(NAME, time) PersonTeam(PERSON_ID, TEAM_NAME, role)
drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');



drop table PersonTeam;
drop table Person;
drop table Team;

create table Person(
        person_id integer Primary Key,
	name varchar(10),
	status char(1)
	);

create table Team(
	team_name varchar(10) Primary Key,
	team_time varchar(10)
	);

create table PersonTeam(
	person_ID integer,
	team_name varchar(10),
	role varchar(10),
	foreign key (Person_ID) references Person(person_id),
	foreign key (Team_Name) references Team(team_name)
	);


--INSERT INTO newTable SELECT existingFields FROM existingTable;
INSERT INTO Person SELECT Distinct personID, name, status FROM AltPerson;
INSERT INTO Team SELECT Distinct teamName, teamTime FROM AltPerson;
INSERT INTO PersonTeam Select Distinct PersonID, teamName, teamRole From AltPerson;

select * from Person;
select * from Team;
select * from PersonTeam;