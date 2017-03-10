--Jesse Hulse
--Exercise 5.3
--A
Select Distinct P1.lastName || ', ' || P1.firstName || ' and ' || P2.firstName || ' - ' || hh.phoneNumber || ' - ' || hh.street
	from Person P1, Person P2, household hh
	where P1.gender = 'm' 
		AND p1.householdID = p2.householdID 
		AND p1.id <> p2.id
		AND p1.householdRole = 'husband'
		AND p2.householdRole = 'wife'
		AND hh.ID = p1.householdID;
--B

Select (Case When (P1.lastName = P2.lastName) Then P1.lastName || ', ' || P1.firstName || ' and ' || P2.firstName || ' - ' || hh.phoneNumber || ' - ' || hh.street
	else P1.lastName || ', ' || P1.firstName || ' and ' || P2.firstName || ' ' || P2.lastName ||' - ' || hh.phoneNumber || ' - ' || hh.street End)
	from Person P1, Person P2, household hh
	where P1.gender = 'm' 
		AND p1.householdID = p2.householdID 
		AND p1.id <> p2.id
		AND p1.householdRole = 'husband'
		AND p2.householdRole = 'wife'
		AND hh.ID = p1.householdID;
--C

Select Distinct Case when (P1.householdRole = 'single' AND hh.ID = p1.householdID) 
		Then P1.lastName || ', ' || P1.firstName || ' - ' || hh.phoneNumber || ' - ' || hh.street
	When (P1.lastName = P2.lastName AND P1.gender = 'm' AND p1.householdID = p2.householdID AND p1.id <> p2.id AND p1.householdRole = 'husband' AND p2.householdRole = 'wife' AND hh.ID = p1.householdID) 
		Then P1.lastName || ', ' || P1.firstName || ' and ' || P2.firstName || ' - ' || hh.phoneNumber || ' - ' || hh.street
	When(P1.lastName != P2.lastName AND P1.gender = 'm' AND p1.householdID = p2.householdID AND p1.id <> p2.id AND p1.householdRole = 'husband' AND p2.householdRole = 'wife' AND hh.ID = p1.householdID) 
		then  P1.lastName || ', ' || P1.firstName || ' and ' || P2.firstName || ' ' || P2.lastName ||' - ' || hh.phoneNumber || ' - ' || hh.street End
	from Person P1, Person P2, household hh;

 


