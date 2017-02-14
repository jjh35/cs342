--Jesse Hulse, lab02
--repeated primary key, error - unique  constraint violated
INSERT INTO Movie VALUES (1,'Star Wars 2',1979,8.7);
--null primary key, error: cannot insert NULL into ("JJH"."MOVIE"."ID");
INSERT INTO Movie VALUES (NULL,'Star Wars 2',1979,8.7);
--violation of a check constraint, error: check constraint violated
INSERT INTO Casting VALUES (1,1,'b');
--violation of an SQL datatype constraint, error: invalid number
INSERT INTO Movie VALUES (5,'Blade Runner 4','2 thousand',2.6);
--negative score value, no error because score is a float without any additional contraints
INSERT INTO Movie VALUES (4,'Blade fddRunner',1982,-8.6);
--new record with a null value for foreign key, no error, forign keys are allowed to be null
INSERT INTO Casting VALUES (NULL,1,'star');
--foreign key that doesn't exist in a parent table, error integrity constraint violated - parent key not found
INSERT INTO Casting VALUES (12,1,'star');
--key value in a referenced table with no related records in the referencing table, no error, ever entry in a reference table does not need to be referenced
INSERT INTO Movie VALUES (314,'Blade Runner',1982,8.6);
--delete a referenced record that is referenced by a referencing record, no error, but all entries in a child table that referenced that record that was delelted was also deleted
Delete from movie where id = 1;
--delete a referencing record that references a referenced record, no error, this is a legitimate operation
delete from casting where movieID = 1 and performerID = 1;
--Modify the ID of a movie record that is referenced by a casting record, error integrity constraint violated - child record found
update movie set id = 14 where year = 1977;
