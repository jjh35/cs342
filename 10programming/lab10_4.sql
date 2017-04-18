
--Concurrently running the original procedure in two different consoles did not work. I first set the rank equal to 1, and then ran the procedure twice concurrently
--At the end, the rank should have been 10,001, but instead it was  51,288. The issue is that the updates are interleaved, so when when procudre one graps the rank
--value (call it y) updates it (now its y+1) but then the second process takes control and updates it, say 5 times. Then the first process graps the rank value and it should
--be y+1, but now its y+6. So the value is incorrectly increased. I would say this is some type of lost update problem, but it does not fit the description in the
--book .
--I added the for update clause at the end of my select statement, and this fixed the issue
CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn for update;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/

--EXECUTE incrementRank(238071, 1);
