

--For a given user's team on a given week, select the players' name, team, and score.
--A user who wants to check how his or her team is doing will want this query.
--Alternate forms: This is query is just a multi-inner join, so other ways would be more complicated. I could have used an in(select...) but a simple
--join is better
select p.name || ' ' ||  p_t.name ||' ' || p_s.score
	from player p, user_profile u_p, user_team u_t, player_score p_s, Team_Player t_p, pro_team p_t
	where u_p.id = 1 
		AND p.pro_team = p_t.id 
		AND u_p.id = u_t.user_id
		AND u_t.name = 'goal diggers' 
		AND t_p.team_id = u_t.id 
		AND t_p.player_id = p.id 
		AND p.id = p_s.player_id
		AND p_s.week = 1;
		
--For a given week and given user's team, select the total score for that team
--A user will want to check the total score for a team.
--Alternate form: this multi-inner join is grouped by user profile name, week, and user_team name, so I can't think of an alternate way of doing it,
--other than using the join ... on ... syntax or using a less optimal nested subquery
select 'user ' || u_p.name ||  ' has ' || 'team ' || u_t.name || ' that scored ' ||  sum(p_s.score) || ' points for week ' || p_s.week
	from player p, user_profile u_p, user_team u_t, player_score p_s, Team_Player t_p, pro_team p_t
	where u_p.id = 1 
		AND p.pro_team = p_t.id 
		AND u_p.id = u_t.user_id
		AND u_t.name = 'goal diggers' 
		AND t_p.team_id = u_t.id 
		AND t_p.player_id = p.id 
		AND p.id = p_s.player_id
		AND p_s.week = 1
	group by u_p.name, p_s.week, u_t.name;
	
	

--This view allows a person to check on the performance of unowned players by showing their scores per week.
--If a person wants to make a transfer, then they will want to look at this view.
--This should be a non-materalized view because it changes often, so it should be re-run each time the user wants to view it.
--Alternate form: This query requires a not in, so I can't think of an alternate way of doing it
create or replace view unowned_players as 
	select distinct p.name as player_name, p_t.name as team_name, p_s.week as week, p_s.score as score
	From player p, player_score p_s, pro_team p_t
	 where 
		p_s.player_id = p.id
		AND p.pro_team = p_t.id
		AND p.id not in 
			(select tp.player_id
				from team_player tp, user_team ut, user_profile up 
				where tp.team_id = ut.id 
					AND ut.name = 'goal diggers' 
						AND up.name = 'experianced');
	 
--This select finds the average scores for unowend players.
--This will be useful for people wanting to make transfers.
--Alternate method: This query is simple, and their isn't a better way of doing it.
select p.player_name, AVG(p.score)
	from unowned_players p
	group by p.player_name;
	
--This query retrieves all match_up scores for a given week. (if a match_up has not started yet, then the scores will be null).
--People who want to check the performance of their team will user this query.
--Alternate form: this is a a multi-inner join with a not null check, I can't think of a better way of doing this. 
--One could use a nested subquery, but this wouold not be optimal
select  m_u.team2_ID as opponent, m_u.team1_score as your_score, m_u.team2_score as opponent_score
	from match_up m_u, user_team u_t
	where m_u.team1_score is not null 
		AND m_u.team1_ID = u_t.id 
		AND u_t.name = 'goal diggers';
	
	
--This query returns a list of a user's teams and what league they are in. If any on the teams are not in a league, print out a null value for the league name.
--A user might want to check what league their various teams are in.
--Alternate forms: this nested inner and outer join statement is complicated, and I cannot think of a better/different way of this this.
select u_t.name as team, l.name as league
	from  User_profile u_p join 
		(User_team ut join 
			(User_team u_t left outer join fantasy_league l on u_t.fantasy_league = l.id) 
		on u_t.user_id = ut.id) 
	on ut.user_id = u_p.id AND u_p.id = 1;
	
--This query prints out the user and their reference, and it will print null if there is no reference.
--The administator might want to check this, or a user may be curious about who they were references for.
--Alternate method: This is a self-joining query. One could do a nested subquery, but again this is not optimal
select u_p.name as user_profile, reference.name as reference
from user_profile u_p left outer join user_profile reference on u_p.reference = reference.id;


	


	



