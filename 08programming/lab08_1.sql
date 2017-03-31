

create or replace procedure addActorToCasting (actor_id in Actor.ID%type, movie_id in Movie.ID%type, role_name in Role.role%type) as
Begin
	INSERT into Role Values(actor_id, movie_id, role_name);
end;
/


create or replace trigger roleIntegrity before insert on Role for each row
declare
counterForAlreadyCast integer;
counterForCastings integer;
actorAlreadyCast EXCEPTION;
toManyCastings EXCEPTION;
begin
select count(*) into counterForAlreadyCast from Role
	where actorId = :new.actorId AND movieId = :new.movieId;
	if counterForAlreadyCast > 0 then
		raise actorAlreadyCast;
	end if;

select count(*) into counterForCastings from role where movieId = :new.movieId;
	if counterForCastings > 230 then
		raise toManyCastings;
	end if;

EXCEPTION
	When actorAlreadyCast then
		RAISE_APPLICATION_ERROR(-20001, 'actor already cast');
	When toManyCastings then
		RAISE_APPLICATION_ERROR(-20001, 'to many castings');
	
end;
/
--a
execute addActorToCasting(89558, 238073, 'new role');
--b
execute addActorToCasting(89558,238073, 'new role');
--c
execute addActorToCasting(89557,167324, 'new role');
