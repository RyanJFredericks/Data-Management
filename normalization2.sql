DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS clothes;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS details;


-- Suppliers --
CREATE TABLE suppliers (
  sid     char(5) not null,
  name    text,
  address    text,
  city text,
  state text,
  postal integer,
  contact text,
  paymentTerms text,
 primary key(sid)
);        

-- Clothes --
CREATE TABLE clothes2 (
  SKU      char(5) not null,
  sid     char(5) not null references suppliers(sid),
  description     text,
  priceUSD     decimal (10,2),
  quantity integer,
 primary key(SKU)
);



-- Orders --
CREATE TABLE orders (
  ordno      integer not null,
  sid     char(5) not null references suppliers(sid),
  dateO date,
  comments text,
 primary key(ordno)
);


  
-- Details -- 
CREATE TABLE details1 (
  did     char(5) not null,
  ordno     integer not null references orders(ordno),
  SKU     char(5) not null references clothes2(SKU),
  sid     char(5) not null references suppliers(sid),
  qtyPur  integer,
  purPrice integer,
 primary key(did)
);



--SUPPLIERS INSERT
INSERT INTO suppliers(  sid, name, address, city, state, postal, contact, paymentTerms )
  VALUES('S0001', 'Whats Sup', '101 You Drive', 'New York', 'NY', 13913, 'Steve from Accounting', 'Check');
  
INSERT INTO suppliers(  sid, name, address, city, state, postal, contact, paymentTerms )
  VALUES('S0002', 'The Clothes Depot', '221B Baker Street', 'Los Angeles', 'CA', 23912, 'Sherlock', 'Cash');

  
INSERT INTO suppliers(  sid, name, address, city, state, postal, contact, paymentTerms )
  VALUES('S0003', 'NHL Store', '42nd Street', 'New York', 'NY', 13913, 'Wayne', 'Cash');

  select *
  from suppliers;


--CLOTHES2 INSERT
INSERT INTO clothes2( SKU, sid, description, priceUSD, quantity )
  VALUES('C0001', 'S0001', 'T-Shirt', 15.99, 100 );

INSERT INTO clothes2( SKU, sid, description, priceUSD, quantity )
  VALUES('C0002', 'S0002', 'Jeans', 21.99, 80 );

INSERT INTO clothes2( SKU, sid, description, priceUSD, quantity )
  VALUES('C0003', 'S0001', 'Jeans', 24.99, 50 );

INSERT INTO clothes2( SKU, sid, description, priceUSD, quantity )
  VALUES('C0004', 'S0003', 'Jersey', 99.99, 30 );

  select *
  from clothes2;

--ORDER INSERTS
INSERT INTO orders( ordno, sid, dateO, comments )
  VALUES('00001', 'S0001', '2014-04-03', 'Never late');

INSERT INTO orders( ordno, sid, dateO, comments )
  VALUES('00002', 'S0002', '2014-05-01', 'Need asap');

 INSERT INTO orders( ordno, sid, dateO, comments )
  VALUES('00003', 'S0001', '2014-05-25', 'Re-order');

  INSERT INTO orders( ordno, sid, dateO, comments )
  VALUES('00004', 'S0003', '2014-06-30', 'Summer Birthdays');

  select *
  from orders;

--DETAILS1 INSERTS
INSERT INTO details1( did, ordno, SKU, sid, qtyPur, purPrice )
  VALUES('D0001', 00001, 'C0001', 'S0001', 100, 30.00);

INSERT INTO details1( did, ordno, SKU, sid, qtyPur, purPrice )
  VALUES('D0002', 00003, 'C0003', 'S0003', 400, 120.00);

INSERT INTO details1( did, ordno, SKU, sid, qtyPur, purPrice )
  VALUES('D0003', 00001, 'C0002', 'S0001', 20, 50.00);

  select *
  from details1;


--QUERY

select (clothes2.quantity + details1.qtyPur)
from clothes2, details1
where clothes2.SKU = details1.SKU;


  