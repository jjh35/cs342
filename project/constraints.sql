

alter table Player_Score
	add constraint played_constraint
	CHECK (played in (0,1));

alter table Player_score
	add constraint clean_sheet_constraint
	Check (clean_sheet in (0,1,null));