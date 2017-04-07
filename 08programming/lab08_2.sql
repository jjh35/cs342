-- Insert your results into this table.
CREATE TABLE SequelsTemp (
  id INTEGER,
  name varchar2(100),
  PRIMARY KEY (id)
 );
 
CREATE OR REPLACE PROCEDURE getSequels (movieIdIn IN Movie.id%type) AS
	name varchar2(100);
	sequel integer;
begin
	select name into name from movie where id = movieIDin; 
	insert into SequelsTemp values(movieIdIn,name);

	select count(*) into sequel from movie where id = movieIDin + 1;

	if sequel <> 0 then
		getSequels(movieIDin + 1);
	end if;


	-- Fill this in based on:
	--     the cursor example in class exercise 8.2.b.
	--     the recursive procedure example in class exercise 8.3.b.
END;
/

-- Get the sequels for Ocean's 11, i.e., 4 of them.
BEGIN  getSequels(238071);  END;
/
SELECT id as ID, name as title FROM SequelsTemp;

delete from SequelsTemp where id like '%';

-- Get the sequels for Ocean's Fourteen, i.e., none.
BEGIN  getSequels(238075);  END;
/
SELECT id as ID, name as title FROM SequelsTemp;

-- Clean up.
DROP TABLE SequelsTemp;