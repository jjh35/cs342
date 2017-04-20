
--Concurrently running the original procedure in two different consoles did not work. I first set the rank of 176712 equal to 8.5, and then ran the procedure twice concurrently
--with deltaIn set at 0.1. At the end, the rank should have been 10,008.5, but instead it was  6921.9. The issue is that the updates are interleaved, so the first procedure graps the rank
--value (call it y), but then the second process reads the value (y) and both increment it by 0.1, then they both write the value, and the second one overwrites the first.
--This is an example of the lost update problem.

--I added the "for update" clause at the end of my select statement, and this fixed the issue
CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn for update;
		--dbms_output.put_line(x);
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/

--EXECUTE incrementRank(176712, 0.1);
