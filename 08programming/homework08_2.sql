drop table BaconTable;
create table BaconTable(
	actorID integer primary key,
	baconNumber integer
);

drop table movieDone;
create table movieDone(
mID integer primary key
);

--TEST VALUES (TEST GRAPH)
--delete from role where actorid like '%';
-- insert into actor values(1,'1', '1', 'M');
-- insert into actor values(2,'1', '1', 'M');
-- insert into actor values(3,'1', '1', 'M');
-- insert into actor values(4,'1', '1', 'M');
-- insert into actor values(5,'1', '1', 'M');
-- insert into actor values(6,'1', '1', 'M');
-- insert into actor values(7,'1', '1', 'M');
-- insert into actor values(8,'1', '1', 'M');
-- insert into actor values(9,'1', '1', 'M');
-- insert into actor values(10,'1', '1', 'M');
-- insert into actor values(11,'1', '1', 'M');

-- insert into movie values(1,'name',1995, 3.0,null);
-- insert into movie values(2,'name',1995, 3.0,null);
-- insert into movie values(3,'name',1995, 3.0,null);
-- insert into movie values(4,'name',1995, 3.0,null);
-- insert into movie values(5,'name',1995, 3.0,null);
-- insert into movie values(6,'name',1995, 3.0,null);
-- insert into movie values(7,'name',1995, 3.0,null);

-- --movie 1 has actors 1,2,3
-- insert into role values(1,1,'1');
-- insert into role values(2,1,'1');
-- insert into role values(3,1,'1');

-- --movie 2 has actor 1,4,5
-- insert into role values(1,2,'1');
-- insert into role values(4,2,'1');
-- insert into role values(5,2,'1');

-- --movie 3 has actors 1,6
-- insert into role values(1,3,'1');
-- insert into role values(6,3,'1');
-- insert into role values(8,3,'1');

-- --movie 4 has actors 4,7
-- insert into role values(4,4,'1');
-- insert into role values(7,4,'1');

-- --movie 5 has actors 7 and 8
-- insert into role values(8,5,'1');
-- insert into role values(7,5,'1');
-- insert into role values(1,5,'1');

-- insert into role values(8,6,'1');

-- insert into role values(9,6,'1');



create or replace procedure findActorNumber(id in integer) as
	countLimit integer;
	dummy integer;
begin
	insert into BaconTable values(id, 0);
	countLimit := 1;
	while countLimit <= 20 loop
		dummy := extraFun(id, id, 1, countLimit);
		
		delete from movieDone where mID like '%';
		countLimit := countLimit + 1;
	end loop;

end;
/




create or replace function extraFun(baseActorID in integer, currentActorID in integer, counter in integer, countLimit in integer) return integer as
	alreadyExists integer;
		dummy integer;
		bc integer;
	begin
		if counter = countLimit then
			return 1;
		end if;
		
		for movie in (select distinct movieID from role where actorID = currentActorID minus select distinct mID from movieDone) loop
			for movie in (select distinct movieID from role where actorID = currentActorID minus select distinct mID from movieDone) loop
				insert into movieDone values(movie.movieID);
			end loop;
			
			
			for coActor in (select actorID from role r where r.movieID = movie.movieID) loop
				--dbms_output.put_line(coactor.actorID);
				--if we come to an actor that has not been inserted into the table, insert them
				select count(*) into alreadyExists from BaconTable bt where coActor.actorID =  bt.actorID;
				if alreadyExists = 0 then
					insert into BaconTable Values(coActor.actorID, counter);
				end if;
				if alreadyExists = 1 then
					select baconNumber into bc from baconTable where baconTable.actorid = coActor.actorID;
					if counter < bc then
						update baconTable set baconNumber = counter where actorID = coActor.actorID;
					end if;				
				end if;
					
			end loop;
			
			--for each actor, look up their movie and recurse
			for coActor in (select actorID from role r where r.movieID = movie.movieID) loop
				dummy := extraFun(baseActorID, coActor.actorID, counter + 1, countLimit);
			end loop;
	
		end loop;
		
		
		return 1;
end extraFun;
/


execute findActorNumber(1);


select actorID as actor, BaconNumber as baconNumber from baconTable order by baconNumber desc;

--select baconNumber, count(*) from baconTable group by baconNumber order by baconNumber asc;