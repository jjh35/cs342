--This procedure will go the the player score table and calcualte the players' score based on their goals, assits, etc
create or replace procedure findPlayerScores(inWeek IN match_up.week_number%type) as
score integer;
goal_points integer;
played_points integer;
assist_points integer;
clean_sheet_points integer;
begin
		for player in (select id from player) loop
			select 5 * sum(goals) into goal_points from player_score where player_score.week = inWeek and player.id = player_score.player_id;
			select 2 * played into played_points from player_score where player_score.week = inWeek and player.id = player_score.player_id;
			select 3 * sum(assists) into assist_points from player_score where player_score.week = inWeek and player.id = player_score.player_id;
			select 4 * nvl(clean_sheet,0) into clean_sheet_points from player_score where player_score.week = inWeek and player.id = player_score.player_id;
			update player_score set score = goal_points + played_points + assist_points + clean_sheet_points where player_score.week = inWeek and player_score.player_id = player.id;
		end loop;
end;
/


--thie procedure will calculate the match_up scores for a given week;
create or replace procedure findTeamScores(inWeek IN match_up.week_number%type) as
	p_score integer;
	team_score integer;
begin
	team_score := 0;
	for fantasy_team in (select distinct team1_ID from match_up where week_number = inWeek) loop

			for player in (select distinct player_id from team_player where team_player.team_id = fantasy_team.team1_ID) loop
				select score into p_score from player_score where player_score.player_id = player.player_id and player_score.week = inWeek;
				team_score := team_score + p_score;
			end loop;
			
		update match_up set team1_score = team_score where week_number = inWeek and team1_id = fantasy_team.team1_id;
		team_score := 0;
	end loop;
	for fantasy_team in (select distinct team2_ID from match_up where week_number = inWeek) loop
			for player in (select distinct player_id from team_player where team_player.team_id = fantasy_team.team2_ID) loop
				select score into p_score from player_score where player_score.player_id = player.player_id and player_score.week = inWeek;
				team_score := team_score + p_score;
			end loop;
		update match_up set team2_score = team_score where week_number = inWeek and team2_id = fantasy_team.team2_id;
		team_score := 0;
	end loop;
end;
/

execute findPlayerScores(1);
execute findTeamScores(1);

--test queries
select player_Id as player, score as score, goals as goals, played as played, assists as asssits, clean_sheet as clean_sheet, week as week from player_score where week = 1;
select distinct team1_score as team1_score, team1_ID as team1_id, team2_score as team2_score, team2_id as team2_id from match_up where week_number = 1;
