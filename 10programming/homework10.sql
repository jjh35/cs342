CREATE OR REPLACE PROCEDURE transferRank(movieId1 IN Movie.id%type, movieId2 IN Movie.id%type, transfer_amount Movie.rank%type ) as
	below_zero_exception EXCEPTION;
	above_ten_exception EXCEPTION;
	does_not_exist EXCEPTION;
	validMovie1 Movie.rank%type;
	validMovie2 Movie.rank%type;
	payer_balance Movie.rank%type;
	payee_balance Movie.rank%type;
BEGIN
	
	LOCK TABLE movie
	IN EXCLUSIVE MODE;
	
	select count(*) into validMovie1 from movie where id = movieId1;
	select count(*) into validMovie2 from movie where id = movieId2;
	
	if validMovie1 = 0 or validMovie2 = 0 then
		raise does_not_exist;
	end if;

	select rank into payer_balance from movie where id = movieId1 for update;
	select rank into payee_balance from movie where id = movieId2 for update;
	
	if payer_balance - transfer_amount  <= 0 then
		raise below_zero_exception;
	end if;
	
	if payee_balance + transfer_amount > 10 then
		raise above_ten_exception;
	end if;
	
	update movie set rank = payer_balance - transfer_amount where id = movieId1;
	update movie set rank = payee_balance + transfer_amount where id = movieId2;
	
	commit;
EXCEPTION
	WHEN  below_zero_exception THEN
		RAISE_APPLICATION_ERROR(-20001, 'balance at or below zero!');
	When does_not_exist then
		RAISE_APPLICATION_ERROR(-20001, 'Movie does not exist!');
	When above_ten_exception then
		RAISE_APPLICATION_ERROR(-20001, 'Balance above 10!');
	
END;
/