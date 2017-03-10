--Jesse Hulse

--Exercise 6.1
Select Distinct t.name || ' ' || t.mandate || ' ' || pt.personID
	FROM team t LEFT OUTER JOIN PersonTeam pt
	ON t.name = pt.teamName AND pt.role = 'chair';


--Exercise 6.2
--a
select TRUNC(AVG(MONTHS_BETWEEN(SYSDATE, p.birthdate))/12)
	from person p;
	-- it does use an agregate function, it uses the default grouping of just one group
--b
select hh.ID, count(*)
	from household hh, person p
	where p.householdID = hh.id
	group by hh.id
	Having count(*) > 1;

--c
select hh.ID, count(*), hh.phoneNumber
	from household hh, person p
	where p.householdID = hh.id
	group by hh.id, hh.phoneNumber
	Having count(*) > 1;
