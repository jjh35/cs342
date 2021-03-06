create table Pro_League(
ID integer Primary Key,
name varchar(32) NOT NULL
);

create table Pro_Team(
ID integer Primary Key,
name varchar(32) NOT NULL,
league integer,
foreign key (league) references Pro_League(ID) ON DELETE CASCADE
); 

create table Position (
position_name varchar(16) primary key
);

create table Player(
ID integer Primary Key,
name varchar(32) NOT NULL,
pro_team integer NOT NULL,
position varchar(16) NOT NULL,
goals int,
assists int,
clean_sheets int,
foreign key (pro_team) references Pro_Team(ID) ON DELETE CASCADE,
foreign key (position) references Position(position_name)
);

create table User_Profile(
ID integer Primary Key,
name varchar(32) NOT NULL,
reference integer,
foreign key (reference) references User_Profile(ID)
);


create table Fantasy_League(
ID integer Primary Key,
game_count integer NOT NULL,
name varchar(32) NOT NULL
);

create table User_Team(
ID integer Primary key,
name varchar(32) NOT NULL,
user_id integer NOT NULL,
fantasy_league integer,
record varchar(10),
foreign key (user_id) references User_Profile(ID) ON DELETE CASCADE,
foreign key (fantasy_league) references Fantasy_League(ID)
);

create table Team_Player(
team_ID integer NOT NULL,
player_ID integer NOT NULL,
foreign key (team_id) references User_Team(ID) ON DELETE CASCADE,
foreign key (player_Id) references Player(ID) ON DELETE CASCADE,
Primary key (team_ID, player_ID)
);

create table Match_Up(
team1_ID integer NOT NULL,
team2_ID integer NOT NULL,
--fantasy_season integer NOT NULL,
team1_score integer,
team2_score integer,
week_number integer NOT NULL,
foreign key (team1_ID) references User_Team(ID) ON DELETE CASCADE,
foreign key (team2_ID) references User_Team(ID) ON DELETE CASCADE,
Primary key (team1_ID, team2_ID, week_number)
);

create table Player_Score(
player_ID integer NOT NULL,
week integer NOT NULL,
score integer,
played integer,
goals integer,
assists integer,
clean_sheet integer,
foreign key (player_ID) references Player(ID) ON DELETE CASCADE,
Primary Key (Player_ID, week)
);

