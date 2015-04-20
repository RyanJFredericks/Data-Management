DROP TABLE IF EXISTS staff;



-- Staff --
CREATE TABLE staff (
  staffID     	char(8) not null,
  fname    	text,
  lname    	text,
  age 		integer,
 primary key(staffID)
);        


--Engineer -- 
CREATE TABLE engineers (
  staffID 	char(8) not null,
  degree	text,
  videogame	text,
  primary key (staffID)
  );

-- Flight Control Operators -- 
CREATE TABLE flightControlOperators (
  staffID	char(8) not null,
  chair		text,
  drink		text,
  hangover	text,
  primary key (staffID)
  );


-- Astronauts --
CREATE TABLE astronauts (
  staffID 	char(8) not null,
  yearsFlying	integer,
  handicap	integer,
  spouse	text,
  primary key (staffID)
  );

-- Spacecrafts --
CREATE TABLE spacecrafts (
  sid, 