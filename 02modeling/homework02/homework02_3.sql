

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
