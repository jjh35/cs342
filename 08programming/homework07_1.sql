--homework 7
--1

Create or replace view employee_dep as
	select e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
	From Employees e, departments d
	where d.department_id = e.department_id;
	
--a.
 select first_name, last_name, employee_id, hire_date
	from employee_dep
	where department_name = 'Executive'
	AND hire_date in (Select Max(hire_date) from employee_dep where department_name = 'Executive'); 

				
--b
Update employee_dep set department_name = 'Bean Counting' where department_name = 'Administration';
--This will not work because the departments table is not key preserved (the department_id is not included), thus 
--I cannot update a column which maps to a non key preserved table


--c
Update employee_dep set first_name = null where last_name = 'Manuel';
--works

--d
Insert into employee_dep Values(207, 'first name', 'last_name', 'me@mail.com', '11-Nov-1999', 'new department');
--This will not work because the departments table is not key preserved (the department_id is not included), thus 
--I cannot update a column which maps to a non key preserved table. 'new department' is not in the departments table.
--Also, it is not legal to modify more than one table through a join view




