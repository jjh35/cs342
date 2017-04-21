insert into Pro_League Values(1, 'English Premier League');
insert into Pro_League Values(2, 'La Liga');
insert into Pro_League Values(3, 'Bundsliga');
insert into Pro_League Values(4, 'Serie A');
insert into Pro_League Values(5, 'MLS');

insert into Pro_Team Values(1, 'Liverpool Football Club', 1);
insert into Pro_Team Values(2, 'Arsenal', 1);
insert into Pro_Team Values(3, 'Tottenham Hotspur F.C.', 1);
insert into Pro_Team Values(4, 'Burnley', 1);
insert into Pro_Team Values(5, 'Everton Football Club', 1);
insert into Pro_Team Values(6, 'Barcelona', 2);
insert into Pro_Team Values(7, 'Real Madrid', 2);
insert into Pro_Team Values(8, 'Bayern Munich', 3);
insert into Pro_Team Values(9, 'Hamsburg', 3);
insert into Pro_Team Values(10, 'Dortmund', 3);
insert into Pro_Team Values(11, 'Juventus', 4);
insert into Pro_Team Values(12, 'Roma', 4);
insert into Pro_Team Values(13, 'Seattle Sounder', 5);
insert into Pro_Team Values(14, 'LA Galaxy', 5);
insert into Pro_Team Values(15, 'Chicago Fire', 5);
insert into Pro_Team Values(16, 'Inter Milan', 4);
insert into Pro_Team Values(17, 'Manchester City', 1);
insert into Pro_Team Values(18, 'West Ham United', 1);
insert into Pro_Team Values(19, 'AC Milan', 4);
insert into Pro_Team Values(20, 'Chelsea', 1);
insert into Pro_Team Values(21, 'Leicester city', 1);
insert into Pro_Team Values(22, 'Hull City', 1);
insert into Pro_Team Values(23, 'Athletico Madrid', 2);
insert into Pro_Team Values(24, 'Manchester United', 1);


insert into position Values('forward');
insert into position Values('midfield');
insert into position Values('defense');
insert into position Values('goalie');


insert into Player Values(1, 'Simon Mignolet', 1, 'goalie', 0, 0, 4);
insert into Player Values(2, 'Ragnar Clavan', 1, 'defense', 1, 3, 3);
insert into Player Values(3, 'Dejan Lovren', 1, 'defense', 1, 3, 2);
insert into Player Values(4, 'Nathaniel Clyne', 1, 'defense', 1, 1, 2);
insert into Player Values(5, 'James Milner', 1, 'defense', 1, 5, 6);
insert into Player Values(6, 'Jordan Hnderson', 1, 'midfield', 5, 8, 6);
insert into Player Values(7, 'Adam Lallana', 1, 'midfield', 10, 10, 6);
insert into Player Values(8, 'Phlippe Coutinho', 1, 'midfield', 12, 13, 7);
insert into Player Values(9, 'Roberto Firmino', 1, 'midfield', 10, 12, 7);
insert into Player Values(10, 'Daniel Sturridge', 1, 'forward', 3, 2, null);
insert into Player Values(11, 'Divock Origi', 1, 'forward', 3, 2, null);
insert into Player Values(12, 'Petr Cech', 2, 'goalie', 0, 0, 6);
insert into Player Values(13, 'Laurent Koscielny', 2, 'defense', 1,1, 4);
insert into Player Values(14, 'Alexis Sanchez', 2, 'forward', 15, 10, 5);
insert into Player Values(15, 'Olivier Giroud', 2, 'forward', 10, 3, null);
insert into Player Values(16, 'Romelu Lukaku', 3, 'forward', 18, 4, null);
insert into Player Values(17, 'Harry Kane', 6, 'forward', 19, 15, null);
insert into Player Values(18, 'Lionel Messi', 7, 'forward', 45, 15, null);
insert into Player Values(19, 'Ronaldo', 7, 'forward', 1, 15, null);
insert into Player Values(20, 'Xavi', 6, 'midfield', 6, 15, 4);
insert into Player Values(21, 'Pique', 6, 'defense', 19, 15, 4);
insert into Player Values(22, 'Puyol', 6, 'defense', 19, 15, 4);
insert into Player Values(23, 'Umtiti', 6, 'defense', 1, 1, 4);



insert into User_Profile Values(1, 'experianced',null);
insert into User_Profile Values(2, 'not so much',1);
insert into User_Profile Values(3, 'user3',1);
insert into User_Profile Values(4, 'user4',2);
insert into User_Profile Values(5, 'user5',4);
insert into User_Profile Values(6, 'user6',null);
insert into User_Profile Values(7, 'user7',null);
insert into User_Profile Values(8, 'user8', 2);



insert into Fantasy_League Values(1, 36, 'YNWO');
insert into Fantasy_League Values(2, 36, 'Imports');
insert into Fantasy_League Values(3, 36, 'Exports');
insert into Fantasy_League Values(4, 36, 'Hopefuls');

insert into User_team Values(1,'goal diggers', 1, 1, '5,1,2');
insert into User_team Values(9,'Klopp in the Kop', 1, null, null);
insert into User_team Values(10,'Messi for President', 1, 2, null);

insert into User_team Values(2,'losers', 2, 2, '0,3,5');
insert into User_team Values(3,'losers', 3, 3, '0,3,5');
insert into User_team Values(4,'try hards', 4, 1, '0,3,5');
insert into User_team Values(5,'team5', 5, 1, '0,3,5');
insert into User_team Values(6,'tea6', 6, 2, '0,3,5');
insert into User_team Values(7,'team7', 7, 3, '0,3,5');
insert into User_team Values(8,'team8', 8, 4, '0,3,5');




insert into Team_Player Values(1,1);
insert into Team_Player Values(1,2);
insert into Team_Player Values(1,3);
insert into Team_Player Values(1,4);
insert into Team_Player Values(1,5);
insert into Team_Player Values(1,6);
insert into Team_Player Values(1,7);
insert into Team_Player Values(1,8);
insert into Team_Player Values(1,9);
insert into Team_Player Values(1,10);
insert into Team_Player Values(1,11);
insert into Team_Player Values(1,12);
insert into Team_Player Values(1,13);
--insert into Team_Player Values(1,23);


insert into Team_Player Values(2,9);
insert into Team_Player Values(2,10);
insert into Team_Player Values(2,11);
insert into Team_Player Values(2,12);
--not player 13
insert into Team_Player Values(2,14);
insert into Team_Player Values(2,15);
insert into Team_Player Values(2,16);
insert into Team_Player Values(2,17);
insert into Team_Player Values(2,18);
insert into Team_Player Values(2,19);
insert into Team_Player Values(2,20);
insert into Team_Player Values(2,21);
insert into Team_Player Values(2,22);
insert into Team_Player Values(2,23);

--week 1 scores
insert into Match_Up Values(1, 2, 25, 2, 1);
insert into Match_Up Values(1, 3, 5, 20, 2);
insert into Match_Up Values(1, 4, 81, 20, 3);
insert into Match_Up Values(1,5,null,null,4);

--week 2 scores
insert into Match_Up Values(2, 3, 20, 20, 2);
insert into Match_Up Values(3, 4, 20, 20, 4);
insert into Match_Up Values(4, 5, 20, 20, 5);
insert into Match_Up Values(7, 8, 20, 20, 2);
insert into Match_Up Values(8, 6, 20, 20, 2);


insert into Player_Score Values(1,1,4,1,0,0,1);
insert into Player_Score Values(2,1,1,1,0,0,1);
insert into Player_Score Values(3,1,14,1,1,1,0);
insert into Player_Score Values(4,1,9,1,2,1,1);
insert into Player_Score Values(5,1,8,1,0,0,1);
insert into Player_Score Values(6,1,6,1,0,1,1);
insert into Player_Score Values(7,1,5,1,0,0,0);
insert into Player_Score Values(8,1,6,1,0,1,0);
insert into Player_Score Values(9,1,7,1,2,3,1);
insert into Player_Score Values(10,1,6,1,1,0,null);
insert into Player_Score Values(11,1,2,1,0,0,null);
insert into Player_Score Values(12,1,5,1,0,0,0);
insert into Player_Score Values(13,1,12,1,1,0,1);
insert into Player_Score Values(14,1,18,1,1,1,1);
insert into Player_Score Values(15,1,1,1,1,1,0);
insert into Player_Score Values(16,1,1,1,1,1,null);
insert into Player_Score Values(17,1,2,1,1,1,null);
insert into Player_Score Values(18,1,2,1,1,1,null);
insert into Player_Score Values(19,1,2,1,1,1,null);
insert into Player_Score Values(20,1,1,1,1,1,1);
insert into Player_Score Values(21,1,7,1,1,1,0);
insert into Player_Score Values(22,1,0,1,1,1,1);
insert into Player_Score Values(23,1,7,1,1,1,1);

insert into Player_Score Values(1,2,12,1,1,1,1);
insert into Player_Score Values(2,2,11,1,1,1,1);
insert into Player_Score Values(3,2,12,1,1,1,0);
insert into Player_Score Values(4,2,8,1,1,1,0);
insert into Player_Score Values(5,2,2,1,1,1,1);
insert into Player_Score Values(6,2,0,1,1,1,1);
insert into Player_Score Values(7,2,2,1,1,1,1);
insert into Player_Score Values(8,2,4,1,1,1,0);
insert into Player_Score Values(9,2,1,1,1,1,1);
insert into Player_Score Values(10,2,16,1,1,1,null);
insert into Player_Score Values(11,2,1,1,1,1,null);
insert into Player_Score Values(12,2,2,1,1,1,1);
insert into Player_Score Values(13,2,1,1,1,1,1);
insert into Player_Score Values(14,2,8,0,1,1,0);
insert into Player_Score Values(15,2,11,1,1,1,null);
insert into Player_Score Values(16,2,2,1,2,1,null);
insert into Player_Score Values(17,2,3,1,0,1,null);
insert into Player_Score Values(18,2,5,1,0,1,null);
insert into Player_Score Values(19,2,3,1,1,1,null);
insert into Player_Score Values(20,2,2,1,1,1,1);
insert into Player_Score Values(21,2,2,1,0,1,1);
insert into Player_Score Values(22,2,1,1,1,1,0);
insert into Player_Score Values(23,2,1,1,2,1,1);












