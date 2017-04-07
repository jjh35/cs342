
--Build sample queries to test that:

--there is a benefit to using either COUNT(1) , COUNT(*) or SUM(1) for simple counting queries.
declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(*) into dummy from actor;
END LOOP;
END;
/
--Elapsed: 00:00:01.23

declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(1) into dummy from actor;
END LOOP;
END;
/
--Elapsed 00:00:01.25

declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select sum(1) into dummy from actor;
END LOOP;
END;
/
--Elapsed: 00:00:02.56
--These times are almost identical, so there is no difference with COUNT(1) , COUNT(*) or SUM(1)

--the order of the tables listed in the FROM clause affects the way Oracle executes a join query.
declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(*) into dummy from actor,movie,role where movie.id = role.movieid and role.actorid = actor.id and actor.id = 22591;
END LOOP;
END;
/
--Elapsed: 00:00:05.45

declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(*) into dummy from role,actor,movie where movie.id = role.movieid and role.actorid = actor.id and actor.id = 22591;
END LOOP;
END;
/
--Elapsed: 00:00:05.43

declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(*) into dummy from movie,role,actor where movie.id = role.movieid and role.actorid = actor.id and actor.id = 22591;
END LOOP;
END;
/
--Elapsed: 00:00:05.45
--The time for the join is virtually the same regardless of the order of the table in the from clause

--the use of arithmetic expressions in join conditions (e.g., FROM Table1 JOIN Table2 ON Table1.id+0=Table2.id+0 ) affects a query’s efficiency.
declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(*) into dummy from movie join actor on movie.id = actor.id;
END LOOP;
END;
/
--Elapsed: 00:00:14.75

declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(*) into dummy from movie join actor on movie.id + 0 = actor.id+0;
END LOOP;
END;
/
--Elapsed: 00:00:16.67
--The use of the arithetic expression in the join seemed to slow down the join by just a little bit.

--running the same query more than once affects its performance.

select count(*) from movie join actor on movie.id = actor.id;
--Elapsed: 00:00:00.15

declare
dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
select count(*) into dummy from movie join actor on movie.id = actor.id;
END LOOP;
END;
/
--Elapsed: 00:00:14.48/100 = 0.14
--Running the same query multiple times did not affect the run time.

--adding a concatenated index on a join table improves performance (see the create index command described above).

select count(*) from role r1 join role r2 on r1.actorid = r2.movieid;

create index roleIndex on Role(movieID, ActorID);

select count(*) from role r1 join role r2 on r1.actorid = r2.movieid;

drop index roleIndex;

--creating an index does not work
--ERROR at line 1:
--ORA-01652: unable to extend temp segment by 128 in tablespace SYSTEM
--Creating the indecies seemed to use up all the memeory avaliable for indexing this table.