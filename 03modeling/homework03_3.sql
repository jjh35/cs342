 --Jesse Hulse, homework 3: 3. Exercise 9.11
 
 drop table Order_Part;
 drop table Cust_Order;
 drop table Employee;
 drop table Customer;
 drop table Part;

 --Stores info about an employee
 create table Employee(
	 Employee_Number integer  PRIMARY KEY,
	 First_Name varchar(32) NOT NULL,
	 Last_Name varchar(32) NOT NULL,
	 Zip_Code integer
	 );

--stores info about customers
 create table Customer(
	 Customer_Number integer PRIMARY KEY,
	 First_Name varchar(32),
	 Last_Name varchar(32) NOT NULL,
	 Zip_Code integer
	 );

 --stores info about a part
 create table Part(
	 Part_Number integer PRIMARY KEY,
	 Part_Name varchar(32),
	 Price float,
	 Quantity integer
	 );

--The table that relates a customer with a specific order
create table Cust_Order(
	ID integer PRIMARY KEY,
	Sales_Person integer NOT NULL,
	Cust_ID integer NOT NULL,
	Order_Placed_Date date,
	Ex_Ship_Date date,
	Ac_Ship_Date date,
	FOREIGN KEY (Sales_Person) REFERENCES Employee(Employee_Number),
	FOREIGN KEY (Cust_ID) REFERENCES Customer(Customer_Number) ON DELETE CASCADE --delete the customer order if the customer is deleted
	);

--keeps track of what parts make up an order
create table Order_Part(
	Order_ID integer NOT NULL,
	Part_Num integer NOT NULL,
	Quantity integer,
	FOREIGN KEY (Order_ID) REFERENCES Cust_Order(ID) ON DELETE CASCADE, --delete the order for a part if the order is deleted
	FOREIGN KEY (Part_Num) REFERENCES Part(Part_number) ON DELETE CASCADE --delete the reference to the part table if order is deleted
	);

--Sample Data
insert into Employee Values(0,'John','Smith', 49504);
insert into Customer Values(0, 'Susan', 'Jones', 33222);
insert into Customer Values(1, 'Timmy', 'lil', 33222);
insert into Part Values(0,'machine', 300, 20);
insert into Part Values(1,'gear', 300, 20);
insert into Cust_Order Values(0,0,0,'02-JAN-02','05-JAN-02', NULL);
insert into Cust_Order Values(1,0,1,'02-JAN-02','05-JAN-02', NULL);
insert into Order_Part Values(0, 0, 1);
insert into Order_Part Values(0, 1, 2);
insert into Order_Part Values(1, 1, 1);

--test query, find the names of the parts order by an Customer of a specified ID (in this case 0) 
select Customer.First_Name || ' ' || Customer.Last_Name || ' ' || Part.Part_Name from Customer, Cust_Order, Order_Part, Part
	where Customer.Customer_Number = 0 AND 
		  Customer.Customer_Number = Cust_Order.Cust_ID AND
		  Order_Part.Order_ID = Cust_Order.ID AND
		  Order_Part.Part_Num = Part.Part_Number;
