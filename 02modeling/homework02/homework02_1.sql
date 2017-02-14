--Jesse Hulse, HW 2, Exercise 5.14

--Drop tables
DROP TABLE SHIPMENT;
DROP TABLE WAREHOUSE;
DROP TABLE ORDER_ITEM;
DROP TABLE ITEM;
DROP TABLE CUSTOMERORDER;
DROP TABLE CUSTOMER;


CREATE TABLE CUSTOMER(
 Cust# integer NOT NULL,
 Cname varchar(70),
 City varchar(70),
 PRIMARY KEY (Cust#)
); 

CREATE TABLE CUSTOMERORDER(
Order# integer NOT NULL,
Odate date,
Cust# integer NOT NULL,
Ord_amt float,
PRIMARY KEY (Order#),
--if a custormer is deleted, then his or her order information is no longer needed, so delete it
FOREIGN KEY (Cust#) REFERENCES CUSTOMER(Cust#) ON DELETE CASCADE
);

CREATE TABLE ITEM(
Item# integer NOT NULL,
Item_name varchar(70),
Unit_price float,
PRIMARY KEY (Item#)
);

CREATE TABLE ORDER_ITEM(
Order# integer NOT NULL,
Item# integer NOT NULL,
Qty integer,
--if an order has been deleted, then the information about the order should be removed as well
FOREIGN KEY (Order#) REFERENCES CUSTOMERORDER(Order#) ON DELETE CASCADE,
FOREIGN KEY(Item#) REFERENCES ITEM(Item#)  ON DELETE CASCADE
);

CREATE TABLE WAREHOUSE(
Warehouse# integer NOT NULL,
City varchar(70),
PRIMARY KEY (Warehouse#)
);

CREATE TABLE SHIPMENT(
Order# integer NOT NULL,
Warehouse# integer,
Ship_date date,
--if an order is deleted, then the shipping information about that order should be as well.
FOREIGN KEY (Order#) REFERENCES CUSTOMERORDER(Order#) ON DELETE CASCADE
);

 --sample records
 INSERT INTO CUSTOMER VALUES(1, 'customer 1', 'Grand Rapids');
 INSERT INTO CUSTOMER VALUES(2, 'customer 2', 'New York');
 INSERT INTO CUSTOMER VALUES(3, 'customer 3', 'Cookeville');

 INSERT INTO CUSTOMERORDER VALUES(1, '01-JAN-02', 3, 3.50);
 INSERT INTO CUSTOMERORDER VALUES(2, '01-JAN-01', 2, 38.50);
 INSERT INTO CUSTOMERORDER VALUES(3, '02-JAN-02', 2, 9.00);
 INSERT INTO CUSTOMERORDER VALUES(4, '12-NOV-07', 2, 100.00);
 INSERT INTO CUSTOMERORDER VALUES(5, '12-NOV-07', 3, 100.00);
 INSERT INTO CUSTOMERORDER VALUES(6, '12-NOV-07', 1, 100.00);

 INSERT INTO ITEM VALUES(1, 'item 1', 2.33);
 INSERT INTO ITEM VALUES(2, 'item 2', 0.99);
 INSERT INTO ITEM VALUES(3, 'item 3', 2222.90);

 INSERT INTO ORDER_ITEM VALUES(1, 2, 2);
 INSERT INTO ORDER_ITEM VALUES(2, 1, 1);
 INSERT INTO ORDER_ITEM VALUES(3, 3, 3);
 INSERT INTO ORDER_ITEM VALUES(4, 2, 1);
 INSERT INTO ORDER_ITEM VALUES(5, 2, 3);
 INSERT INTO ORDER_ITEM VALUES(6, 2, 1);

 INSERT INTO SHIPMENT VALUES(1,1,'02-JAN-02');
 INSERT INTO SHIPMENT VALUES(2,2,'06-JAN-02');
 INSERT INTO SHIPMENT VALUES(3,4,'07-JAN-02');

 INSERT INTO WAREHOUSE VALUES(1, 'Grand Rapids');
 INSERT INTO WAREHOUSE VALUES(2, 'East Town');
 INSERT INTO WAREHOUSE VALUES(3, 'Grandville');


--all the order dates and amounts for orders made by a customer with a particular name (one that exists in your database), 
--ordered chronologically by date
select Ord_amt || ' '  || Odate  FROM CUSTOMERORDER, CUSTOMER 
	WHERE CUSTOMER.Cname = 'customer 2' AND CUSTOMER.Cust# = CUSTOMERORDER.Cust# 
	ORDER BY Odate ASC;
 
 --all the customer ID numbers for customers who have at least one order in the database
 SELECT DISTINCT Cust# from CUSTOMERORDER;

 --the customer IDs and names of the people who have ordered an item with a particular name (one that exists in your database)
 select DISTINCT CUSTOMER.Cust# || ' ' || CUSTOMER.Cname from CUSTOMER, CUSTOMERORDER, ITEM, ORDER_ITEM
	WHERE Item.Item_name = 'item 2' AND 
		ORDER_ITEM.Item# = Item.Item# AND 
		ORDER_ITEM.Order# = CUSTOMERORDER.Order# AND
		CUSTOMERORDER.Cust# = CUSTOMER.CUST#;
