--Exercise 5.2
--A
SELECT *
FROM (SELECT * FROM Person Where birthdate IS NOT NULL ORDER BY birthdate DESC)
WHERE ROWNUM = 1;

--B
--if three people have the same name, then without the Disctinct constraint, each of the three people will be printed 
--twice because they match the requairments of the query twice (there are two other people with the same name
Select Distinct m.ID || ' ' || m.firstName || ' ' || m.lastName 
from Person p, Person m
Where p.firstName = m.firstName AND p.ID <> m.ID;

--C
SELECT Distinct P.firstName || ' ' || P.lastName
FROM PersonTeam PT, Person P
WHERE P.ID = PT.personID
AND PT.teamName = 'Music'
AND NOT EXISTS (SELECT *
                 FROM HomeGroup HG
                 WHERE p.homeGroupID = HG.ID AND HG.name = 'Byl' );
