
--Get the cities of agents booking an order for a customer whose pid is 'c006'
select city
from agents
where aid in (  select aid
		from orders
		where orders.cid='c006');

--Get the pids of products ordered through any agent who takes at least one order from a customer in Kyoto, sorted by pid from highest to lowest. (This is not the same as asking for pids of products ordered by customers in Kyoto.)
select pid
from products
where pid in (  select pid 
		from orders
		where cid in (  select cid
				from customers
				where city='Kyoto'))
ORDER BY pid DESC;


--Get the cids and names of customers who did not place an order through agent a03
select cid, name
from customers
where cid NOT in (  select cid
		from orders
		where orders.aid = 'a03');


--Get the cids of customers who ordered both product p01 and p07.   ISSUES
select cid
from customers
where cid in (  select cid
		from orders
		where orders.pid = 'p01')
INTERSECT

select cid
from customers
where cid in (  select cid
		from orders
		where orders.pid = 'p07');


--Get the pids of products NOT ordered by any customers who placed any order through agent a05.
select pid
from products
where pid NOT in (select pid 
		  from orders
		  where cid in 
			( select cid
			  from orders
			  where orders.aid ='a05'));

--Get the name, discounts, and city for all customers who place orders through agents in Dallas or New York. 
select name, discount, city
from customers
where cid in (  select cid
		from orders
		where aid in (  select aid
				from agents
				where city = 'Dallas' OR city = 'New York'));

--Get all customers who have the same discount as that of any customers in Dallas or London
--Using London causes issues within the script, not sure   POSSIBLE ISSUE?
select *
from customers 
where discount in (	select discount 
			from customers
			where city = 'Dallas')
AND city <> 'Dallas';



--Tell me about check constraints: What are they? What are they good for? What’s the advantage of putting that sort of thing inside the database? Make up some examples of good uses of check constraints and some examples of bad uses of check constraints. Explain the differences in your examples and argue your case.


--Check constraints are used to create certain limitations or rules for a value within a database.  They are useful for 
