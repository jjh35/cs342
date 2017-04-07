
drop table RankLog;
create table RankLog(
userID varchar(32),
dateOfChange timestamp Primary Key,
original_value number(10,2),
new_value number(10,2)
); 


create or replace
  TRIGGER CheckRank 
  after UPDATE of rank On Movie  
  for each row
  BEGIN
  if :new.rank <> :old.rank then
	Insert Into RankLog Values(user, current_timestamp, :old.rank , :new.rank);
  end if;
  END;
  /
  
  --dbms_output.put_line(user);
	