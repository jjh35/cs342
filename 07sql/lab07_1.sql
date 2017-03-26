 --Jesse Hulse, lab07

 --Exercise 7.1
 Create or replace view birthday_czar as 
	select firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) as age, birthdate
	from Person; 

--a
select firstName, lastName
	from birthday_czar
	where birthdate between '01-JAN-61' AND '31-DEC-75';

--b
Update Person 
	set birthdate = '01-JAN-65'
	where firstName = 'Doug' AND lastName = 'Jones';
--Yes, the new person appeared in the result because we are using a non-materialized view, so when an update happens in the base table,
--the view is updated.

--c
insert into birthday_czar(firstName,lastName, birthdate) Values('Harry', 'Potter', '01-JAN-95');
--No, the birthday_czar table is not key perserved, so inserting will not work. I would have to include a unqiue ID that corresponds to the
--primary key of the person table to insert into the birthday_czar table.

--d
drop view birthday_czar;
--No, the person table is not affected. The birthday_czar table is derived from the person table, so the person table is not affected
--if the view is dropped
