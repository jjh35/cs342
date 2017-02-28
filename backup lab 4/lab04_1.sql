-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

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

--Jesse Hulse

--Exercise 4.1

--A. With all the information about a person stored in a single table, there is a lot of potential for NULL values. The table is poorly designed
 --  to store team information because if a person is on more than one team, then they will have multiple entries in the AltPerson table,
 --  which means that there will be alot of repeated data. For example in the insert statements:
--	INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
--	INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
--   the first 5 values are repeated for Shamkant. If we built a seperate table for team information, then this repeated information 
--   could be eliminated.

--B. I will normalize to BCNF
--We want each functional depedency to be depednent on the primary key, so in the AltPerson table should only contain things that are 
--dependent on it (name, status, mentorID). Build a Team table with columns that are functionally dependent on teamName (teamTime). Build
--a table PersonTeam with a key (personID, teamName) that has information that is functinally dependant on it (teamRole)
