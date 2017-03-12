--Jesse Hulse

--Exercise 6.1
Select Distinct t.name || ' ' || t.mandate || ' ' || pt.personID
	FROM team t LEFT OUTER JOIN PersonTeam pt
	ON t.name = pt.teamName AND pt.role = 'chair';

