--Show the cities of agents booking an order for a customer whose cid is 'c006'. Use joins; no subqueries. 
select city
from agents
join orders On agents.aid = orders.aid
where orders.cid = 'c006';

--Show the pids of products ordered through any agent who makes at least one order for a customer in Kyoto, sorted by pid from highest to lowest. Use joins; no subqueries.                            UNSURE
select pid 
from orders
join customers on customers.cid = orders.cid
where customers.city = 'Kyoto'
ORDER BY pid DESC;

--Show the names of customers who have never placed an order. Use a subquery. 
select name
from customers
where cid NOT in (  select cid
		    from orders  );


--Show the names of customers who have never placed an order. Use an outer join. 
select customers.name
from customers
full outer join Orders ON customers.cid = orders.cid
WHERE orders.cid IS NULL;



--Show the names of customers who placed at least one order through an agent in their own city, along with those agent(s') names. 
-- Cannot get agents name to work
select customers.name
from customers
join orders on customers.cid = orders.cid
WHERE orders.cid in (  select cid 
		from orders
		join agents on orders.aid = agents.aid
		where agents.city = customers.city);


--Show the names of customers and agents living in the same city, along with the name of the shared city, regardless of whether or not the customer has ever placed an order with that agent. 
select customers.name, agents.name
from customers
join agents on agents.city = customers.city
where agents.city = customers.city;



--Show the name and city of customers who live in the city that makes the fewest different kinds of products. (Hint: Use count and group by on the Products table.)
--UNSURE
select name, city, count(city) 
from customer
group by city
where customers.city = products.city;