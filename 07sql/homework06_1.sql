--Jesse Hulse
--Homework 06

--a
Select m.employee_id || ' ' || m.first_name || ' ' || m.last_name || ' ' || count(*)
	From Employees m, Employees e
	where e.manager_id = m.employee_id
	group by m.employee_id, m.first_name, m.last_name
	ORDER BY count(*) DESC
	FETCH FIRST 10 ROWS ONLY;
	
--b
Select d.department_name || '- number of employees: ' || count(*) || ', total salary: ' || SUM(e.salary)
	From Departments d, Employees e 
	where e.department_id = d.department_id
	group by d.department_name
	having count(*) < 100;

--c 
--select DISTINCT d.department_name || ' Name: ' || e.first_name
--	From Departments d LEFT OUTER JOIN Employees e ON d.manager_id = e.employee_id;
		
		
select DISTINCT d.department_name || ' Name: ' || e.first_name || ' ' || j.job_title
	From Departments d LEFT OUTER JOIN Employees e 
			LEFT OUTER JOIN Job_History jh 
					INNER JOIN Jobs j ON jh.job_id = j.job_id 
			ON e.employee_id = jh.employee_id
		 ON d.manager_id = e.employee_id;
		 
--d
Select d.department_name || ' has an average salary of ' ||TRUNC(AVG(e.salary))
	From Departments d Left Outer Join Employees e ON e.department_id = d.department_id
	group by d.department_name
	ORDER BY case when AVG(e.salary) is null then 0 else AVG(e.salary) end DESC;
	