--Display the name and city of customers who live in any city that makes the most different kinds of products. (There are two cities that make the most different products. Return the name and city of customers from either one of those.)
--STILL WORKING ON

select pid
from products
where pid NOT in (select pid 
		  from orders
		  where cid in 
			( select cid
			  from orders
			  where orders.aid ='a05'));

--Display the names of products whose priceUSD is below the average priceUSD, in alphabetical order. 
select name
from products
where priceUSD > (select avg(priceUSD) from products);


--Display the customer name, pid ordered, and the dollars for all orders, sorted by dollars from high to low.
select customers.name, orders.pid, orders.dollars
from customers
join orders on customers.cid = orders.cid
ORDER BY dollars DESC;


--Display all customer names (in reverse alphabetical order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs. s
SELECT customers.name, SUM(orders.dollars) 
FROM customers, orders
GROUP BY customers.name
Order by customers.name DESC;


--Display the names of all customers who bought products from agents based in Tokyo along with the names of the products they ordered, and the names of the agents who sold it to them. 



--Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from data in other tables and comparing those values to the values in Orders.dollars. Display all rows in Orders where Orders.dollars is incorrect, if any. 


--What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries in SQL to demonstrate. (Feel free to use the CAP2 database t make your points here.)
