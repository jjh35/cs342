-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;


--Exercise 4.2
--a. These relations are in BCNF form because  1. teamName is not functionally dependent on personName or vice-versa (a person may have many 
--differnt team assingments). 2. personVisit is not functionally dependent on personName (a person may have more than one visit). So by default
--these 2 relations are in BCNF. These relations are in 4th normal form because they are in BCNF and they do not contain more than one multivalued
--dependancy.
--b. There are not functional dependencies in this combined view, so it is in BCNF and 4th normal form by default.
--c. Not exactly.   In order to uniquely identify a row in the combined view, all three columns must be specified because none of the
--value are dependent on each other. Having the 2 seperate views stores the teamNames and visists of a person without worrying about the 
--other. If someone wants to know when someone visits, then they look the PersonVisit table. If they want to look at what teams a person is on
--they check the person visit table. So in this context, there is no need to have the combined view. 

