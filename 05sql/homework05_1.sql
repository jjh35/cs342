--1
--A
select  distinct e.employee_id || ' ' || e.first_name || ' ' || e.last_name   
	from employees e, jobs j , job_history jh 
	where e.job_id = j.job_id 
	AND j.job_id = jh.job_id 
	AND NOT EXISTS (Select *
		From employees emp, jobs job, job_history job_h
		Where emp.job_id = job.job_id AND job.job_id = job_h.job_id AND job_h.end_date IS NULL
);


--B 
select distinct e1.employee_id || ' ' || e1.first_name || ' ' || e1.last_name || ' has manager ' || manager.employee_id || ' ' || manager.first_name || ' ' || manager.last_name
	from employees e1, employees manager, job_history jh, departments d
	where manager.employee_id = e1.manager_id
	AND manager.hire_date > e1.hire_date
	AND jh.employee_id = e1.employee_id
	AND jh.department_id = manager.department_id;
 
--C
--join query
Select Distinct c.country_name 
	from countries c, locations l, departments d 
	where d.location_id = l.location_id AND l.country_id = c.country_id; 
--nested query
Select Distinct country_name 
	from (select * from countries c, locations l, departments d  where d.location_id = l.location_id AND l.country_id = c.country_id); 
--the join query is better because there is no need to have a separate select statement when a simple join will do the same thing.
-- plus the second query requires to select statements, so this might require more computation time

--select * From(select distinct e.manager_id from departments d, job_history jh, employees e where jh.department_id = d.department_id AND d.manager_id = e.manager_id ); 
