--Ryan Fredericks
--4/27/15
--
-- An example stored procedure ("function")
--
CREATE LANGUAGE plpgsql;

--PreReqsFor stored procedure
create or replace function PreReqsFor(integer, REFCURSOR) returns refcursor as 
$$
declare
   num int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select preReqNum
      from   Prerequisites
       where  num = courseNum;
   return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(499, 'results');
Fetch all from results;



--IsPreReqFor stored procedure
create or replace function IsPreReqFor(integer, REFCURSOR) returns refcursor as 
$$
declare
   num int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select courseNum
      from   Prerequisites
       where  num = preReqNum;
   return resultset;
end;
$$ 
language plpgsql;

select IsPreReqFor(120, 'results');
Fetch all from results;


