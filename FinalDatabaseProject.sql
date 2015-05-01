DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS moveType;
DROP TABLE IF EXISTS moves;
DROP TABLE IF EXISTS gimmicks;
DROP TABLE IF EXISTS whenHeld;
DROP TABLE IF EXISTS accomplishments;
DROP TABLE IF EXISTS wrestlers;
DROP TABLE IF EXISTS isRelated;
DROP TABLE IF EXISTS relatives;
DROP TABLE IF EXISTS backstageWorkers;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS zipCodes;


-- zipCodes --
CREATE TABLE zipCodes (
  zip     	char(5) not null,
  city    	text not null,
  state    	text not null,

  primary key(zip)
);     

INSERT INTO zipCodes(  zip, city, state)
  VALUES('06883', 'Weston', 'CT');
INSERT INTO zipCodes(  zip, city, state)
  VALUES('11733', 'Setauket', 'NY');
INSERT INTO zipCodes(  zip, city, state)
  VALUES('73301', 'Austin', 'TX');
INSERT INTO zipCodes ( zip, city, state)
  VALUES('37760', 'Jefferson City', 'TN');


select *
from zipCodes;



-- People --
CREATE TABLE people (
  personID     	char(5) not null,
  fname		text not null,
  lname		text not null,
  dateOfBirth	date not null,
  zip		text not null references zipCodes(zip),

  primary key(personID)
);   

INSERT INTO people ( personID, fname, lname, dateOfBirth, zip)
  VALUES('P0001', 'Paul', 'Levesque', '1969-07-29', '06883');
INSERT INTO people ( personID, fname, lname, dateOfBirth, zip)
  VALUES('P0002', 'Mick', 'Foley', '1965-06-07', '11733');
INSERT INTO people ( personID, fname, lname, dateOfBirth, zip)
  VALUES('P0003', 'Stephanie', 'McMahon', '1976-09-24', '06883');
INSERT INTO people ( personID, fname, lname, dateOfBirth, zip)
  VALUES('P0004', 'Mark', 'Calaway', '1965-03-24', '73301');
INSERT INTO people ( personID, fname, lname, dateOfBirth, zip)
  VALUES('P0005', 'Glenn', 'Jacobs', '1967-04-26', '37760');
    
select *
from people;
  
-- BackstageWorkers --
CREATE TABLE backstageWorkers (
  personID 	char(5) not null references people(personID),
  workerType	text not null,
  dateBeginning date not null,
  primary key(personID)
);

INSERT INTO backstageWorkers ( personID, workerType, dateBeginning)
  VALUES('P0001', 'Executive Vice President',  '1992-03-24');
INSERT INTO backstageWorkers ( personID, workerType, dateBeginning)
  VALUES('P0003', 'Chief Brand Officer',  '1998-01-01');

select *
from backstageWorkers;


-- Relatives --
CREATE TABLE relatives (
  relativeID	char(5) not null,
  personID 	char(5) not null references people(personID),

  primary key(relativeID)
);


INSERT INTO relatives ( relativeID, personID)
  VALUES('R0001', 'P0001');
INSERT INTO relatives ( relativeID, personID)
  VALUES('R0002', 'P0002');
INSERT INTO relatives ( relativeID, personID)
  VALUES('R0003', 'P0003');
INSERT INTO relatives ( relativeID, personID)
  VALUES('R0004', 'P0004');
INSERT INTO relatives ( relativeID, personID)
  VALUES('R0005', 'P0005');
    
select *
from relatives;


-- IsRelated --
CREATE TABLE isRelated (
  personID	char(5) not null references people(personID),
  relativeID	char(5) not null references relatives(relativeID),
  relationType	text not null,

  primary key (personID, relativeID)
);  

INSERT INTO isRelated (personID, relativeID, relationType)
  VALUES('P0001', 'R0003', 'Husband');
INSERT INTO isRelated (personID, relativeID, relationType)
  VALUES('P0003', 'R0001', 'Wife');

select *
from isRelated;

-- Wrestlers --
CREATE TABLE wrestlers (
  personID	char(5) not null references people(personID),
  wid		char(5) not null,
  dateBeginning date not null,
  currAlignment	text not null,
  CHECK (currAlignment = 'Face' OR currAlignment = 'Heel'),
  primary key(wid)
);

INSERT INTO wrestlers ( personID, wid, dateBeginning, currAlignment)
  VALUES('P0001', 'W0001', '1992-03-24', 'Heel');
INSERT INTO wrestlers ( personID, wid, dateBeginning, currAlignment)
  VALUES('P0002', 'W0002', '1996-04-01', 'Face');
INSERT INTO wrestlers ( personID, wid, dateBeginning, currAlignment)
  VALUES('P0004', 'W0003', '1990-11-22', 'Face');
INSERT INTO wrestlers ( personID, wid, dateBeginning, currAlignment)
  VALUES('P0005', 'W0004', '1997-10-05', 'Heel');
  
select *
from wrestlers;

-- Accomplishments --
CREATE TABLE accomplishments (
  aname		text not null,

  primary key (aname)
);

INSERT INTO accomplishments (aname)
  VALUES('WWE Championship');
INSERT INTO accomplishments (aname)
  VALUES('World Heavyweight Championship');
INSERT INTO accomplishments (aname)
  VALUES('Intercontinental Championship');
INSERT INTO accomplishments ( aname)
  VALUES('United States Championship');
INSERT INTO accomplishments ( aname)
  VALUES('Tag Team Championship');
INSERT INTO accomplishments ( aname)
  VALUES('King of the Ring Winner');
INSERT INTO accomplishments ( aname)
  VALUES('Royal Rumble Winner');
INSERT INTO accomplishments ( aname)
  VALUES('Money in the Bank Holder');

select *
from accomplishments;



-- WhenHeld --
CREATE TABLE whenHeld (
  aname		text not null references accomplishments(aname),
  reignNumber	integer not null,
  wid		char(5) not null references wrestlers(wid),
  dateBeginning	date not null,
  dateEnded	date,

  primary key (aname, reignNumber)
);
--Triple H WWE championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 50, 'W0001', '1999-08-23', '1999-09-14');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 52, 'W0001', '1999-09-26', '1999-11-14');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 54, 'W0001', '2000-01-03', '2000-04-30');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 56, 'W0001', '2000-05-21', '2000-06-25');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 64, 'W0001', '2002-03-17', '2002-04-21');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 83, 'W0001', '2007-10-07', '2007-10-07');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 85, 'W0001', '2008-04-27', '2008-11-23');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 89, 'W0001', '2009-02-15', '2009-04-26');
  
--Triple H WHC championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 1, 'W0001', '2002-09-02', '2002-11-17');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 3, 'W0001', '2002-12-15', '2003-09-21');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 5, 'W0001', '2003-12-14', '2004-03-14');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 8, 'W0001', '2004-09-12', '2004-12-06');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 9, 'W0001', '2005-01-09', '2005-04-03');

--Triple H IC Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Intercontinental Championship', 41, 'W0001', '1996-10-21', '1997-02-13');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Intercontinental Championship', 48, 'W0001', '1998-08-30', '1998-10-09');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Intercontinental Championship', 73, 'W0001', '2001-04-03', '2001-04-10');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Intercontinental Championship', 75, 'W0001', '2001-04-16', '2001-05-20');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Intercontinental Championship', 92, 'W0001', '2002-10-20', '2002-10-20');

--Triple H Tag Team Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Tag Team Championship', 30, 'W0001', '2009-12-13', '2010-02-08');

--Triple H Royal Rumble
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning)
  VALUES('Royal Rumble Winner', 15, 'W0001', '2002-01-20');

--Triple H King of the Ring
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning)
  VALUES('King of the Ring Winner', 11, 'W0001', '1997-06-08');

--Mick Foley WWE Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 42, 'W0002', '1998-12-29', '1999-01-24');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 44, 'W0002', '1999-01-26', '1999-02-15');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 49, 'W0002', '1999-08-22', '1999-08-23');

--Undertaker WWE Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 17, 'W0003', '1991-11-27', '1991-12-03');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 35, 'W0003', '1997-03-23', '1997-08-03');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 47, 'W0003', '1999-05-23', '1999-06-28');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 66, 'W0003', '2002-05-19', '2002-07-21');

--Undertaker World Heavyweight Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 15, 'W0003', '2007-04-01', '2007-05-08');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 20, 'W0003', '2008-03-30', '2008-04-30');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 34, 'W0003', '2009-10-04', '2010-02-21');


--Undertaker Royal Rumble Victories
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning)
  VALUES('Royal Rumble Winner', 20, 'W0003', '2007-01-28');

--Kane WWE Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('WWE Championship', 39, 'W0004', '1998-06-28', '1998-06-29');

--Kane World Heavyweight Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('World Heavyweight Championship', 38, 'W0004', '2010-07-18', '2010-12-19');

--Kane Tag Team Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Tag Team Championship', 40, 'W0004', '2011-04-19', '2011-05-23');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Tag Team Championship', 45, 'W0004', '2012-09-16', '2013-05-19');

--Kane Money in the Bank 
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Money in the Bank Holder', 8, 'W0004', '2010-07-18', '2010-07-18');

--Kane Intercontinental Championships
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Intercontinental Championship', 76, 'W0004', '2001-05-20', '2001-06-26');
INSERT INTO whenHeld ( aname, reignNumber, wid, dateBeginning, dateEnded)
  VALUES('Intercontinental Championship', 91, 'W0004', '2002-09-30', '2002-10-20');





  
-- Gimmicks -- 
CREATE TABLE gimmicks (
  wid		char(5) not null references wrestlers(wid),
  gimmickID	char(5) not null,
  gimmickName	text not null UNIQUE,
  isCurrent	boolean not null,
  billedFrom	text not null,
  primary key (gimmickID)
);



INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0001', 'G0001', 'Hunter Hearst Helmsley', FALSE, 'Stamford, CT');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0001', 'G0002', 'Triple H', TRUE, 'Stamford, CT');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0002', 'G0003', 'Mankind', FALSE, 'The Boiler Room');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0002', 'G0004', 'Dude Love', FALSE, 'Long Island, NY');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0002', 'G0005', 'Cactus Jack', FALSE, 'Truth or Consequences, NM');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0002', 'G0006', 'Mick Foley', TRUE, 'Long Island, NY');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0003', 'G0007', 'Undertaker', TRUE, 'Death Valley');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0003', 'G0008', 'American Badass', FALSE, 'Houston, TX');
INSERT INTO gimmicks ( wid, gimmickID, gimmickName, isCurrent, billedFrom)
  VALUES('W0004', 'G0009', 'Kane', TRUE, 'Parts Unknown');    



select *
from gimmicks;
  
-- Moves --
CREATE TABLE moves (
  moveName	text not null,
  description	text not null,
  wid		char(5) not null,
  primary key (moveName)
);

INSERT INTO moves ( moveName, description, wid)
  VALUES('Pedigree', 'Double Underhook Facebuster', 'W0001');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Double Arm DDT', 'DDT', 'W0002');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Mr. Socko', 'Finger placed inside lower jaw', 'W0002');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Cactus Elbow', 'Leaping elbow from apron to outside', 'W0002');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Cactus Clothesline', 'Clothesline that takes both over ropes', 'W0002');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Tombstone Piledriver', 'Kneeling Reverse Piledriver', 'W0003');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Hells Gate', 'Modified Gogoplata', 'W0003');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Last Ride', 'Elevated Powerbomb', 'W0003');
INSERT INTO moves ( moveName, description, wid)
  VALUES('Chokeslam', 'Regular Chokeslam', 'W0003');
  
select *
from moves;

-- moveType --
CREATE TABLE moveType (
  moveName	text not null references moves(moveName),
  gimmickID	char(5) not null references gimmicks(gimmickID),
  finisher	boolean not null,
  signature	boolean not null,

  primary key (moveName, gimmickID)
);

INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Pedigree', 'G0001', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Pedigree', 'G0002', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Double Arm DDT', 'G0003', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Mr. Socko', 'G0003', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Cactus Clothesline', 'G0003', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Double Arm DDT', 'G0004', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Mr. Socko', 'G0004', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Cactus Clothesline', 'G0004', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Double Arm DDT', 'G0005', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Mr. Socko', 'G0005', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Cactus Clothesline', 'G0005', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Cactus Elbow', 'G0005', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Double Arm DDT', 'G0006', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Mr. Socko', 'G0006', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Cactus Clothesline', 'G0006', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Tombstone Piledriver', 'G0007', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Hells Gate', 'G0007', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Last Ride', 'G0007', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Chokeslam', 'G0007', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Tombstone Piledriver', 'G0008', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Hells Gate', 'G0008', FALSE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Last Ride', 'G0008', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Chokeslam', 'G0008', FALSE, TRUE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Tombstone Piledriver', 'G0009', TRUE, FALSE);
INSERT INTO moveType (moveName, gimmickID, finisher, signature)
  VALUES ('Chokeslam', 'G0009', TRUE, FALSE);


select *
from moveType;


-- Groups --
CREATE TABLE groups (
  groupID	char(5) not null,
  groupName	text not null,

  primary key (groupID)
);


INSERT INTO groups (groupID, groupName)
  VALUES ('GR001', 'D-GenerationX');
INSERT INTO groups (groupID, groupName)
  VALUES ('GR002', 'Evolution');
INSERT INTO groups (groupID, groupName)
  VALUES ('GR003', 'Corporation');
INSERT INTO groups (groupID, groupName)
  VALUES ('GR004', 'Authority');
INSERT INTO groups (groupID, groupName)
  VALUES ('GR005', 'Rock N Sock Connection');
INSERT INTO groups (groupID, groupName)
  VALUES ('GR006', 'Brothers of Destruction');


select *
from groups;

-- Members --
CREATE TABLE members (
  groupID 	char(5) not null references groups(groupID),
  gimmickID	char(5) not null references gimmicks(gimmickID),
  isActive	boolean not null,
  isLeader	boolean not null,

  primary key (groupID, gimmickID)
);

INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR001', 'G0002', FALSE, FALSE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR002', 'G0002', FALSE, TRUE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR003', 'G0002', FALSE, FALSE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR004', 'G0002', TRUE, TRUE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR003', 'G0003', FALSE, FALSE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR005', 'G0003', FALSE, FALSE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR005', 'G0006', FALSE, FALSE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR003', 'G0007', FALSE, FALSE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR006', 'G0007', TRUE, TRUE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR006', 'G0008', FALSE, TRUE);
INSERT INTO members (groupID, gimmickID, isActive, isLeader)
  VALUES ('GR006', 'G0009', FALSE, FALSE);



select *
from members;



--Shows different finishers wrestlers have used
--drop view Finishers
CREATE VIEW Finishers
AS
SELECT DISTINCT w.wid AS "Wrestler ID", mt.moveName as "Finisher"
FROM wrestlers w, gimmicks gi, moveType mt
WHERE w.wid = gi.wid AND gi.gimmickID = mt.gimmickID  AND finisher = TRUE
GROUP BY w.wid, mt.moveName;

select *
from Finishers;

--This view shows each accomplishment that each wrestler in the database has gotten.
--drop view Champions
CREATE VIEW Champions
AS
SELECT DISTINCT gi.gimmickName AS "Champions", wh.aname as "Accomplishment"
FROM wrestlers w, gimmicks gi, whenHeld wh, accomplishments a
WHERE w.wid = gi.wid AND w.wid = wh.wid AND a.aname = wh.aname AND gi.isCurrent = TRUE
GROUP BY gi.gimmickName, wh.aname;

select *
from Champions;

--Averages Reigns of Champions
SELECT  wh.wid as Champion, avg(wh.dateEnded - wh.dateBeginning) AS Average_Reign
FROM whenHeld wh
WHERE wh.dateEnded IS NOT NULL AND wh.aname != 'Money in the Bank Holder' 
GROUP BY wh.wid
ORDER BY wid ASC;





--Shows the real life names of people within the company, their gimmicks, and which groups those gimmicks were/are a part of
SELECT  p.lname, p.fname, g.gimmickName, gr.groupName 
FROM people p, wrestlers w, gimmicks g, members m, groups gr
WHERE 	p.personID = w.personID AND
	w.wid = g.wid AND
	g.gimmickID = m.gimmickID AND
	gr.groupID = m.groupID
GROUP BY p.lname, p.fname, g.gimmickName, gr.groupName
Order BY p.lname ASC;



--Defines employees within the company who are both current wrestlers and behind-the-scenes workers

create or replace function FullTimeEmployee(REFCURSOR) returns refcursor as 
$$
declare
   resultset   	REFCURSOR := $1;
begin
   open resultset for 
      select gi.gimmickName as "Gimmick", bw.workerType as "Position"
       from   gimmicks gi, backstageWorkers bw, people p, wrestlers w
       where  	gi.isCurrent = TRUE 
		AND bw.personID IS NOT NULL
		AND p.personID = bw.personID
		AND p.personID = w.personID
		AND w.wid = gi.wid;
   return resultset;
end;
$$ 
language plpgsql;

select FullTimeEmployee('results');
Fetch all from results;


--Defines employees within the company who are faces.  Shows their gimmicks and their wid

create or replace function Faces(REFCURSOR) returns refcursor as 
$$
declare
   resultset   	REFCURSOR := $1;
begin
   open resultset for 
      select gi.gimmickName as "Gimmick", w.wid as "Wrestler"
       from   gimmicks gi, wrestlers w
       where  	gi.isCurrent = TRUE  AND
		w.wid = gi.wid  AND
		w.currAlignment = 'Face';		
   return resultset;
end;
$$ 
language plpgsql;

select Faces('recording');
Fetch all from results;