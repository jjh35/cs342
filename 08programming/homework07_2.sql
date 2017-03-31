

--7
drop MATERIALIZED VIEW materialized_employee_dep;

CREATE MATERIALIZED VIEW materialized_employee_dep as
	SELECT employees.employee_id,
		employees.first_name,
		employees.last_name,
		employees.email,
		employees.hire_date,
		departments.department_name
  FROM employees, departments
  WHERE employees.department_id = departments.department_id;
							  
							  
--a
select first_name, last_name, employee_id
	from materialized_employee_dep
	where department_name = 'Executive' 
	AND hire_date = (Select Max(hire_date) 
			from materialized_employee_dep 
			Where department_name = 'Executive');
			
--b
update materialized_employee_dep set first_name = 'test' where first_name = 'Steven';
--This materialized view cannot be updated (cannot include the for update clause) because
--it is a complex materizialized view (https://docs.oracle.com/cd/B10501_01/server.920/a96567/repmview.htm)
--if a view contians joins other than those in a subquery, then it is complex and cannot be updated

--c
Update materialized_employee_dep set first_name = null where last_name = 'Manuel';
--This will not work because the view cannot be updated as explained in part b

--d
Insert into materialized_employee_dep Values(207, 'first name', 'last_name', 'me@mail.com', '11-Nov-1999', 'new department');
--This will not work because the view cannot be updated as explained in part b




	
