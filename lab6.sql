--Display the name and city of customers who live in any city that makes the most different kinds of products. (There are two cities that make the most different products. Return the name and city of customers from either one of those.)
create view Counting as 
select count(pid)
from products
where products.city = products.city;

select customers.name, customers.city
from customers, products, counting;



--Display the names of products whose priceUSD is below the average priceUSD, in alphabetical order. 
select name
from products
where priceUSD > (select avg(priceUSD) from products);


--Display the customer name, pid ordered, and the dollars for all orders, sorted by dollars from high to low.
select customers.name, orders.pid, orders.dollars
from customers
join orders on customers.cid = orders.cid
ORDER BY dollars DESC;


--Display all customer names (in reverse alphabetical order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.
SELECT customers.name, SUM(orders.dollars) 
FROM customers, orders
GROUP BY customers.name
Order by customers.name DESC;


--Display the names of all customers who bought products from agents based in Tokyo along with the names of the products they ordered, and the names of the agents who sold it to them. 
--Issues
create view TokyoDrift AS
select name
from customers
where cid in (  select cid
		from orders
		where aid in (  select aid
				from agents
				where city = 'Tokyo'));
				
				
select products.name, agents.name
from products, agents, TokyoDrift
group by orders.cid;

--Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from data in other tables and comparing those values to the values in Orders.dollars. Display all rows in Orders where Orders.dollars is incorrect, if any. 

select *
from orders,
where dollars <> (qty * priceUSD)
where orders.pid = products.pid;



--What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries in SQL to demonstrate. (Feel free to use the CAP2 database to make your points here.)

--The difference between the right and left outer joins is which data is taken from the join.   The left outer join takes all the rows from whatever the left table is, even if there are no matching columns in the right table.  The right outer join takes all the rows from the right table, even though they may not all match the left table.   

select *
from customers 
left outer join orders 
on customers.cid = orders.cid;

select cid
from customers 
right outer join orders 
on customers.cid = orders.cid;