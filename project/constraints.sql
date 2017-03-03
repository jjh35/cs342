alter table Player
	add constraint position_constraint
        CHECK (position in ('F', 'M', 'D', 'G'));