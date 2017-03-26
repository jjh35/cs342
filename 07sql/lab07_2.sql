--Homework
--a
--drop materialized view materalized_birthday_czar;
create  materialized view materalized_birthday_czar AS
select firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12), birthdate
   from Person;

--b
select firstName, lastName
	from materalized_birthday_czar
	where birthdate between '01-JAN-61' AND '31-DEC-75';
--No, the result of the query did not change because we are using a materalzied view, so the materalized view was not updated
-- when the base table changed.

--c
insert into materalized_birthday_czar(firstName,lastName, birthdate) Values('Harry', 'Potter', '01-JAN-95');
--No, since we do not have For Update As when we create our view, then the view is read only. If I wanted to insert into the 
--materalized_birthday_czar view, I would have to include the For Update As, drop the age (because there is not a one to one mapping
--from age to birthdate), and I would have to include the ID to make the materalized view key preserved.
--The following would be the implementation of my explanation
--create  materialized view materalized_birthday_czar2 For Update AS
--select ID, firstName, lastName, birthdate
--  from Person;
 --insert into materalized_birthday_czar2 Values(200,'dfdf','dfdfd', '01-JAN-95');


--d
drop materialized view materalized_birthday_czar;
--deleting the materialized view (the fascade) does not change the base table
