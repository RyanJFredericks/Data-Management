
select ordno, dollars
from orders;

select name, city
from agents
where name='Smith';

select pid, name, priceUSD
from products
where quantity > 200000;

select name, city
from customers
where city='Dallas';

select name
from agents
where city<>'New York'
AND city<>'Tokyo'; 

select *
from products
where city<>'Dallas'
AND city<>'Duluth'
AND priceUSD>1;

select *
from orders
where mon='jan'
OR mon='may';

select *
from orders
where mon='feb'
AND dollars>500;

select *
from customers
where cid='c005';


