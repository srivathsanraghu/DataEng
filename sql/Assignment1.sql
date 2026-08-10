-----Assignment  : 
-----1.⁠ ⁠Create a database,schema and sample table in sql 
-----2.⁠ ⁠Explain DDL vs DML ,Truncate vs Delete 
-----3.⁠ ⁠Create 5 tables of your own , each table should have one primary key and one other constraint so each table should have 2 constraint 
-----4.⁠ ⁠Insert data into 5 tables and do a update in 2 table 
-----5.⁠ ⁠Do a TCL using savepoint on a table 
-----6.⁠ ⁠Perform basic DQL operation on any one of the created table which has data.

---------------- Create a database,schema and sample table in sql 
create DATABASE assignment1

use assignment1

-----creating an schema

CREATE SCHEMA cricket;

----------------------------------------------creating an sample table-----------------------------------

CREATE TABLE cricket.sample (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    emailid VARCHAR(100) UNIQUE
)

----------------------------------------------inserting an record into sample table-----------------------------------

insert into cricket.[sample] VALUES
(1, 'Arun', 'chennai', 'arun.1@xyz.com'),
(2, 'Rahul', 'trichy', 'rahul.92@xyz.com'),
(3, 'Kumar', 'chennai', 'ku89.26@xyz.com'),
(4, 'sri', 'coimbatore', 'sri93.1@xyz.com'),
(5, 'ranjith', 'coimbatore', 'rangith.20@xyz.com')

----------------------------------------------View record-----------------------------------

select * from cricket.[sample]



---------------------------------------------- Explain DDL vs DML ,Truncate vs Delete -------------------------------

--- DDL -> Data Definition language. defining the table structure for a data in to rows and column. used to create, Alter
--- DML -> Data Manipulation Languaga. Manipulate the record inside a table based on table structure. used for inserting a data, update, deleting an data., 
--- Truncate -> generally Faster bcoz it removes all the record without analysing inside a table. but it will not disturb the table structure.
--- Delete -> slower bcoz it will analyse and delteteif we use where condition. delete particular record
         ---- where we cannot remove particular record from a table when we use truncate





------- ⁠Create 5 tables of your own , each table should have one primary key and one other constraint so each table should have 2 constraint 
------ Concept -> cricket

----------------------------------------------Table 1-----------------------------------

CREATE TABLE cricket.player (
    capnumber INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age SMALLINT CHECK(age>=18),
    country VARCHAR(50) NOT NULL,
    batting_type VARCHAR(100) NOT NULL,
    bowling_type VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL
)


INSERT into [cricket].[player] VALUES
(10, 'sharma',21,'india','LHB','Right off spin', 'opener'),
(09, 'sanju',32,'india','RHB','WK', 'opener'),
(42, 'ishan',24,'india','LHB','WK', 'opener'),
(31, 'surya',30,'india','RHB','NA', 'Batter'),
(30, 'iyer',31,'india','RHB','NA', 'Batter'),
(100, 'hardik',32,'india','RHB','Right Fast Medium', 'All rounder'),
(109, 'axer',34,'india','LHB','Left off spin', 'All rounder'),
(05, 'varum',33,'india','RHB','Right Leg spin', 'Spiner'),
(19, 'kuldeep',34,'india','LHB','Left off spin', 'Spiner'),
(22, 'Rana',28,'india','RHB','ight Fast Medium', 'Bowler'),
(55, 'bumrah',32,'india','RHB','ight Fast', 'Bowler'),
(64, 'Head',33,'AUS','LHB','Right off spin', 'opener'),
(66, 'short',26,'AUS','RHB','Right off spin', 'opener'),
(78, 'maxwell',33,'AUS','RHB','Right off spin', 'All rounder'),
(90, 'inglis',29,'AUS','RHB','WK', 'Batter'),
(68, 'david',34,'AUS','RHB','NA', 'Batter'),
(59, 'stoinis',35,'AUS','RHB','Right fast medium', 'All rounder'),
(24, 'philippe',28,'AUS','RHB','WK', 'Batter'),
(29, 'zampa',37,'AUS','RHB','Right off spin', 'Spiner'),
(190, 'ellis',29,'AUS','RHB','Right fast medium', 'Bowler'),
(14, 'starc',34,'AUS','RHB','Right fast', 'Bowler'),
(87, 'sangha',27,'AUS','RHB','Right off spin', 'Spiner')


----------------------------------------------Table 2-----------------------------------

CREATE TABLE cricket.playerstats (
    playerid INT PRIMARY KEY,
    capnumber INT FOREIGN KEY REFERENCES cricket.player(capnumber),
    name VARCHAR(100) NOT NULL,
    Matches SMALLINT CHECK(Matches>=0),
    runs SMALLINT NOT NULL,
    Average SMALLINT,
    strick_rate SMALLINT NOT NULL,
    best SMALLINT NOT NULL,
    fifties SMALLINT NOT NULL,
    hundreds SMALLINT
)

ALTER TABLE [cricket].[playerstats]
ADD wicket int,
 bowlingavg FLOAT,
 bowlingSR FLOAT,
 playertype VARCHAR(50);

 ALTER TABLE [cricket].[playerstats]
 ALTER column Average FLOAT;

ALTER TABLE [cricket].[playerstats]
 ALTER column strick_rate FLOAT;

INSERT into [cricket].[playerstats] VALUES
(1,10, 'sharma',100,4026,48,149,121,6,3,2,26.5,7.9,'Opener'),
(2,09, 'sanju',110,5009,52,146,131,7,5,0,0,0, 'opener'),
(3,42, 'ishan',62,3012,52,177,91,8,0,0,0,0,'opener'),
(4,31, 'surya',118,5655,55,169,139,6,3,0,0,0,'Batter'),
(5,30, 'iyer',90,4876,56,134,94,9,0,0,0,0,'Batter'),
(6,100, 'hardik',70,2788,49,149,54,11,0,90,13.2,7.8, 'All rounder'),
(7,109, 'axer',150,3055,34,117,59,3,0,88,11.1,9.6, 'All rounder'),
(8,05, 'varum',155,700,13,31,31,0,0,117,14.0,7.4, 'Spiner'),
(9,19, 'kuldeep',200,455,9,19,21,0,0,261,11.1,5.4,'Spiner'),
(10,22, 'Rana',74,988,27,49,44,0,0,79,20.8,17.6,'Bowler'),
(11,55, 'bumrah',200,790,22,34,21,0,0,288,8.8,7.6,'Bowler'),
(12,64, 'Head',102,5098,61,177,142,8,7,0,0,0,'opener'),
(13,66, 'short',109,4034,55,144,106,4,4,56,20.2,17.8,'opener'),
(14,78, 'maxwell',202,2699,49,149,109,7,1,84,13.3,7.5,'All rounder'),
(15,90, 'inglis',98,5200,51,134,102,6,3,0,0,0,'Batter'),
(16,68, 'david',96,3298,44,179,94,6,0,0,0,0,'Batter'),
(17,59, 'stoinis',110,2988,46,137,109,7,1,89,13.1,7.1,'All rounder'),
(18,24, 'philippe',113,4122,53,126,89,9,0,0,0,0,'Batter'),
(19,29, 'zampa',119,455,9,21,34,0,0,117,11.1,8.4,'Spiner'),
(20,190, 'ellis',56,566,8,24,47,0,0,78,11.4,9.6,'Bowler'),
(21,14, 'starc',209,877,11,39,33,0,0,277,14.9,13.3,'Bowler'),
(22,87, 'sangha',31,209,15,19,21,0,0,56,15.3,15.6,'Spiner')


----------------------------------------------Table 3-----------------------------------

CREATE TABLE cricket.stadium (
    stadiumId INT PRIMARY KEY,
    stadiumname VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
)

ALTER TABLE [cricket].[stadium] DROP constraint stadiumname;
ALTER TABLE [cricket].[stadium] ADD constraint stadiumname UNIQUE (stadiumname);

INSERT into [cricket].[stadium] VALUES
(1,'MAC', 'chennai','TN','india'),
(2,'chidambaram', 'bangalore','karnataka','india'),
(3,'NMS', 'ahmedabad','gujarat','india'),
(4,'MCA', 'pune','maharashtra','india'),
(5,'wankhede', 'mumbai','maharashtra','india')

----------------------------------------------Table 4-----------------------------------

CREATE TABLE cricket.matchdetails (
    MatchID INT PRIMARY KEY,
    Matchdesp VARCHAR(50) NOT NULL,
    matchtype VARCHAR(50) NOT NULL,
    matchdate DATETIME UNIQUE,
    stadiumId INT FOREIGN KEY REFERENCES cricket.stadium(stadiumId),
    stadiumName VARCHAR(50) NOT NULL,
    batting_firstscore VARCHAR(100) NOT NULL,
    batting_secondscore VARCHAR(100) NOT NULL,
    winningteam VARCHAR(100) NOT NULL,
    wonby VARCHAR(100) NOT NULL,
    potm VARCHAR(100) NOT NULL,
    capnumber INT FOREIGN KEY REFERENCES cricket.player(capnumber),
    country VARCHAR(50) NOT NULL
)

drop table [cricket].[matchdetails] -> ---not dropping bcoz of foreign key constrain

ALTER TABLE [cricket].[matchdetails] ADD
    toss VARCHAR(50) NOT NULL,
    toss_decition VARCHAR(50) NOT NULL,
    win_by VARCHAR(50) NOT NULL

insert into [cricket].[matchdetails] VALUES
(1,'IND vs AUS 1st ODI','ODI','2026-06-25 13:45:00',1,'MAC','249/6','252/4','ind','6 wickets','iyer',30,'ind','ind','bowl','second batting'),
(2,'IND vs AUS 2nd ODI','ODI','2026-06-27 13:45:00',1,'MAC','298/3','232/9','aus','68 runs','head',64,'aus','aus','bat','first batting'),
(3,'IND vs AUS 3rd ODI','ODI','2026-06-29 13:45:00',3,'NMS','320/2','322/4','ind','6 wickets','sanju',09,'ind','aus','bat','second batting'),
(4,'IND vs AUS 1st T20','T20','2026-07-03 18:45:00',1,'MAC','190/4','191/4','ind','6 wickets','sanju',09,'ind','ind','bowl','second batting'),
(5,'IND vs AUS 2nd T20','T20','2026-07-05 18:45:00',1,'MAC','189/5','184/4','ind','5 runs','sharma',10,'ind','ind','bat','first batting'),
(6,'IND vs AUS 3rd T20','T20','2026-07-08 18:45:00',2,'chidambaram','220/7','224/5','ind','5 wickets','surya',31,'ind','ind','bowl','second batting'),
(7,'IND vs AUS 4th T20','T20','2026-07-10 18:45:00',4,'MCA','249/6','145/6','ind','104 runs','surya',31,'ind','aus','bowl','first batting'),
(8,'IND vs AUS 5th T20','T20','2026-07-13 18:45:00',5,'wankhede','187/4','182/4','ind','5 runs','bumrah',55,'ind','ind','bat','first batting')

----------------------------------------------Table 5-----------------------------------

CREATE TABLE cricket.awards (
    awardid INT PRIMARY KEY,
    awardname VARCHAR(50) NOT NULL,
    playername VARCHAR(100) NOT NULL,
    capnumber INT FOREIGN KEY REFERENCES cricket.player(capnumber),
    matchId INT FOREIGN KEY REFERENCES cricket.matchdetails(MatchID),
    stadiumId INT FOREIGN KEY REFERENCES cricket.stadium(stadiumId)
)

ALTER TABLE [cricket].[awards] ADD reason VARCHAR(50) NOT NULL
ALTER TABLE [cricket].[awards] ADD category VARCHAR(50) NOT NULL

INSERT INTO [cricket].[awards] VALUES
(1,'potm','sanju',09,3,3,'scored 134','ODI'),
(2,'potm','sanju',09,4,1,'scored 121','t20'),
(3,'potm','iyer',30,1,1,'scored 91','ODI'),
(4,'potm','head',64,2,1,'scored 144','t20'),
(5,'potm','sharma',10,5,1,'scored 109','t20'),
(6,'potm','surya',31,6,2,'scored 87','ODI'),
(7,'potm','surya',31,7,4,'scored 98','t20'),
(8,'potm','bumrah',55,8,5,'took 4 wickets','t20')

drop TABLE [cricket].[awards]

CREATE TABLE cricket.awards (
    awardid INT PRIMARY KEY,
    awardname VARCHAR(50) NOT NULL,
    playername VARCHAR(100) NOT NULL,
    capnumber INT FOREIGN KEY REFERENCES cricket.player(capnumber),
    matchdetails VARCHAR(100) NOT NULL,
    reason VARCHAR(50) NOT NULL,
    category VARCHAR(100) NOT NULL,
    matchyear INT CHECK(matchyear>=1990)
)

INSERT INTO [cricket].[awards] VALUES
(1,'potm','sanju',09,'IND vs aus first ODI','scored 134','ODI',2021),
(2,'potm','sanju',09,'IND vs pak third t20','scored 121','t20',2023),
(3,'potm','iyer',30,'IND vs pak first ODI','scored 91','ODI',2025),
(4,'potm','head',64,'IND vs aus third t20','scored 144','t20',2021),
(5,'potm','sharma',10,'IND vs NZ fourth t20','scored 109','t20',2024),
(6,'potm','surya',31,'IND vs aus second ODI','scored 87','ODI',2021),
(7,'potm','surya',31,'IND vs aus second t20','scored 98','t20',2021),
(8,'potm','bumrah',55,'IND vs SL first t20','took 4 wickets','t20',2026)

----------------------------------------------View Rocord-----------------------------------

select * from [cricket].[awards]
select * from [cricket].[matchdetails]
select * from [cricket].[player]
select * from [cricket].[stadium]
select * from [cricket].[playerstats]



------------------------------------update on tables----------------------------------

UPDATE [cricket].[playerstats] SET Matches = 105 where playerid=2

UPDATE [cricket].[playerstats] SET average = 49 where playerid=3

UPDATE [cricket].[playerstats] SET 
average = 51,
Matches = 64 where playerid=3



UPDATE [cricket].[stadium] SET state='TamilNadu' where state ='TN'

UPDATE [cricket].[player] SET age=34 where capnumber=5

update [cricket].[player] SET name='J bumrah' where capnumber=55

update [cricket].[player] SET name='bumrah' where capnumber=55

update  [cricket].[awards] SET [awardname]='POTS' where awardid=1

update [cricket].[matchdetails] SET matchdate='2026-06-25 14:45:00.000' where matchId=1


----------------------------------------------- basic DQL --------------------------------------

select * from [cricket].[player] where country='india'
select DISTINCT player.name from [cricket].[player]
select DISTINCT country from [cricket].[player]
select * from [cricket].[player] ORDER BY country
select * from [cricket].[player] ORDER BY country DESC
select DISTINCT country from [cricket].[player] ORDER BY country DESC
UPDATE [cricket].[player] SET bowling_type = 'Right Fast' WHERE capnumber=55

select * from [cricket].[playerstats]
select * from [cricket].[playerstats] where playertype='opener'
select DISTINCT runs from [cricket].[playerstats] where playertype='opener' ORDER BY runs DESC
select * from [cricket].[playerstats] where Average>=50
select capnumber,name,runs from [cricket].[playerstats] where Average>=50
select capnumber,name,runs from [cricket].[playerstats] where Average>=50 AND strick_rate>=120 AND playertype='batter'
select capnumber,name,runs,average from [cricket].[playerstats] where Average>=30 AND strick_rate>=120 AND playertype='opener'
update [cricket].[playerstats] SET Average = 52 where capnumber=42
select DISTINCT name,runs from [cricket].[playerstats] where playertype='opener' ORDER BY name
select capnumber,name,runs from [cricket].[playerstats] where strick_rate>=120 ORDER BY capnumber
select * from [cricket].[playerstats] where wicket>=50 AND playertype='bowler' OR playertype='spiner'


select * from [cricket].[stadium]
select * from [cricket].[stadium] where country='india'
select * from [cricket].[stadium] where state='TN'
select * from [cricket].[stadium] where city='chennai' OR city='PUNE'

update [cricket].[stadium] SET state='TN' where stadiumId=4
update [cricket].[stadium] SET state='pune' where stadiumId=4


select * from [cricket].[matchdetails]
select * from [cricket].[matchdetails] where matchtype='ODI'
select * from [cricket].[matchdetails] where matchtype='ODI' AND win_by='first batting'
select * from [cricket].[matchdetails] where matchtype='ODI' AND winningteam='ind' AND stadiumId=1
select DISTINCT winningteam from [cricket].[matchdetails] where matchtype='t20'
select DISTINCT winningteam from [cricket].[matchdetails] where stadiumId=1
select DISTINCT potm from [cricket].[matchdetails]
select DISTINCT potm from [cricket].[matchdetails] where matchtype='t20'
select count(potm) from [cricket].[matchdetails]
select potm, count(potm) AS AwardCount from [cricket].[matchdetails] GROUP BY potm ORDER BY AwardCount DESC


select * from [cricket].[awards]
select * from [cricket].[awards] where category='ODI'
select * from [cricket].[awards] where category='t20'
select * from [cricket].[awards] where playername='sanju'
select * from [cricket].[awards] where stadiumId=1
select playername, count(awardname) AS awardnames from [cricket].[awards] GROUP BY playername

select * from [cricket].[awards]
select * from [cricket].[awards] where category='ODI'
select * from [cricket].[awards] where category='t20'
select * from [cricket].[awards] where playername='sanju'
select playername, count(awardname) AS awardnames from [cricket].[awards] GROUP BY playername


---------------------------------------------------------TCL-------------------------------------------

select average,name from [cricket].[playerstats] where capnumber=42 OR capnumber=64

begin transaction

update [cricket].[playerstats] SET Average = 49 where capnumber=42
update [cricket].[playerstats] SET Average = 52 where capnumber=64




begin transaction

update [cricket].[playerstats] SET Average = 48 where capnumber=42
save transaction step1
update [cricket].[playerstats] SET Average = 51 where capnumber=64
rollback transaction step1
commit transaction



