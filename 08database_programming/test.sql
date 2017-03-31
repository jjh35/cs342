drop MATERIALIZED VIEW materialized_employee_dep;

CREATE MATERIALIZED VIEW materialized_employee_dep 
   for update as SELECT employees.employee_id,
									employees.first_name,
									employees.last_name,
									employees.email,
									employees.hire_date,
                                    departments.department_name
                               FROM employees, departments
                              WHERE employees.department_id = departments.department_id;