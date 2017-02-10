--Exercise 1.1 Jesse hulse
--a
DESCRIBE departments;
--b find the number of employees in the employees table
select count(EMPLOYEE_ID) from employees;
--c find the employees with salaray above 1500
select * from employees where salary > 15000;
  --find employes that where hired between two dates
select * from employees where HIRE_DATE BETWEEN '01-JAN-02' AND '30-DEC-04';
-- find employees that do not have area code of 515
select * from employees where PHONE_NUMBER NOT LIKE '%515%';
--d get  names from department
select FIRST_NAME || LAST_NAME from employees where department_id = 100;
--e large join that finds location information 
select locations.city || locations.state_province || locations.country_ID from countries, locations 
	where countries.country_id = locations.country_id and countries.region_id = 3;
--f practice with null
select * from locations where state_province is NULL;
