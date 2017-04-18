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

