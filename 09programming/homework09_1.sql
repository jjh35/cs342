--AlTER INDEX SYS_C007026 INVISIBLE;
select movieid from movieDirector, director where directorId = id and firstName = 'Clint' and lastName = 'Eastwood';

select movieid from movieDirector where directorid in (select id from director where directorId = id and firstName = 'Clint' and lastName = 'Eastwood');

--When the first join runs, the execution Plan uses a hash join. A hash join will speed up the process since the movieDirector has about 380K rows.
--The optimizer picks the smaller table (Director) and builds a hash table on the join key. Then oracle does a full scan of the movieDirector
--table and uses the hash to find where the join condition is met. In order to build the hash table, oracle does a full table scan. So this
--join requires the full scans of both tables once. I ran the command "alter session set "_hash_join_enabled" = false" command and reran the
--query. The execution plan then used the nested loop join technique. For both the hash join and nested loop, the execution time was 0.03 
--of a second. I disabled the index for the director table, but the execution time was not changed. I then ran the second query three times, 
--and the time came out to be 0.03 twice, and 0.04 once. The execution plan was exactly the same (a hash join) for both queries. Thus
--oracle seems to be able to optimize different implementations of the same squery similarily. The first one was simpler to write.

--2
select directorid, count(*)
	from moviedirector 
	group by directorid
	having count(*) > 200;

--The execution plan uses a filter (probably the having clause) on top of a "hash group by" on the movieDirector table. The hash group does a 
--full table scan to build the hash table, then uses the hash to grap all the movies directed by the same director and uses the filter to
--get ones over 200. The hash group by took 0.06 seconds to run. I then ran "alter session set "_gby_hash_aggregation_enabled"=FALSE" and reran
--the query. Orcle then used the sort group by below the filter. The execution time was 0.06 seconds. So use a sort group by instead of the hash
--group by seemed to make no differece. I would expected the hashing to be quicker than sorting, but in this case (probably not always) they
--came out to be the same. When I ran @getIndexes, movieDirector did not have an index, so the index used was the directorID. This is the obvious
--index to use since we are sorting by the directorid.


--3
--AlTER INDEX SYS_C007026 visible;
--Alter INDEX SYS_C007025 visible;
select actor.id 
	from movie, actor, role
	where movie.id = role.movieid and role.actorid = actor.id
	group by actor.id
	having avg(rank) > 8.5 and count(*) > 9; 

--The time elapsed for the initial query was 1.61 seconds. The execution plan creates a hash table for the role table and then does a hash join with the movie table.
--Then it uses a hash group by and uses the filter SUM("RANK")/COUNT("RANK")>8.5 AND COUNT(*)>9 to find thee correct results. this takes about 1.61 seconds. I then 
--disabled the indexes for the actor and movie table, and the execution time was identical. I then ran the command "alter session set "_hash_join_enabled" = false",
--which increased the execution time to 2.53 seconds. In the execution plan, it used a merge join and 2 sort joins. So, using
-- a hash join is much quicker than using merge and sort joins. I then built a materialized view for the actor populatity and the number of movies an actor has been
--in. I then ran a simple join (the last query in this file) and it only took 0.17. This query used a hash join to find where the actorid of one view matched the
--actor id from the other view after the filters of actorPop.averageRank > 8.5 and apperiances > 9 had been applied. This is faster because only one hash join is
--used compared to a hash join and a hash group by used by the first query. Obviously creating the materialzed views required hash joins and group by's, so the gained
--efficiency is simply from not repeating this part of the query. 


--took 1.75 seconds to build this view
create materialized view actorPop as
	select actor.id as actorID, avg(rank) as averageRank
	from movie, actor, role
	where movie.id = role.movieid and role.actorid = actor.id
	group by actor.id;
--took 0.92
create materialized view actorApperiances as
	select actor.id as actorID, count(*) as apperiances
	from actor, role
	where actor.id = role.actorID
	group by actor.id;
--took 0.17
select actorPop.actorid
	from actorPop, actorApperiances
	where actorPop.actorid = actorApperiances.actorid and actorPop.averageRank > 8.5 and apperiances > 9;
	
