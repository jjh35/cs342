
--This trigger checks the number of players on a team when a new team_player is inserted. If the number of players on a team is 
--equal to 11, then no more players should be added (a fantasy team should only have 11 players on it). This cannot be inforced 
--at the schema level, so this trigger is needed. 
create or replace trigger teamIntegrity before insert on team_player for each row
declare
	numberOnTeam integer;
	toManyPlayers EXCEPTION;
begin
	select count(*) into numberOnTeam from team_player
		where team_ID = :new.team_ID;
		if numberOnTeam > 11 then
			raise toManyPlayers;
		end if;

EXCEPTION
	When toManyPlayers then
		RAISE_APPLICATION_ERROR(-20001, 'to many Players');
end;
/

