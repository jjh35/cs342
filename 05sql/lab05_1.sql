--Exercise 5.1
--A. you would get 8*16 because there are 8 households and 16 people (the cross product)
Select * from person, household;
--B
Select firstName || ' ' || lastName || ' ' || TO_CHAR(birthdate, 'DDD') from person where birthdate is not NULL ORDER BY  TO_CHAR(birthdate, 'DDD');
