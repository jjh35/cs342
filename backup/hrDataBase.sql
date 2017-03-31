-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hr
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.10.1



--
-- Table structure for table `Countries`
--

DROP TABLE Countries;

CREATE TABLE Countries (
  country_id char(2) NOT NULL,
  country_name varchar(40) DEFAULT NULL,
  region_id int DEFAULT NULL,
  PRIMARY KEY (country_id),
  KEY countr_reg_fk region_id,
  CONSTRAINT countr_reg_fk FOREIGN KEY (region_id) REFERENCES Regions (region_id)
);




--
-- Table structure for table `Departments`
--

DROP TABLE Departments;

CREATE TABLE Departments (
  department_id int NOT NULL,
  department_name varchar(30) NOT NULL,
  manager_id int DEFAULT NULL,
  location_id int DEFAULT NULL,
  PRIMARY KEY (department_id),
  --KEY dept_loc_fk (location_id),
  --KEY dept_mgr_fk (manager_id),
  CONSTRAINT dept_loc_fk FOREIGN KEY (location_id) REFERENCES Locations (location_id),
  CONSTRAINT dept_mgr_fk FOREIGN KEY (manager_id) REFERENCES Employees (employee_id)
);








--
-- Table structure for table `Employees`
--

DROP TABLE Employees;

CREATE TABLE Employees (
  employee_id int NOT NULL,
  first_name varchar(20) DEFAULT NULL,
  last_name varchar(25) NOT NULL,
  email varchar(25) NOT NULL,
  phone_number varchar(20) DEFAULT NULL,
  hire_date date NOT NULL,
  job_id varchar(10) NOT NULL,
  salary decimal DEFAULT NULL,
  commission_pct decimal DEFAULT NULL,
  manager_id int DEFAULT NULL,
  department_id int DEFAULT NULL,
  PRIMARY KEY (employee_id),
  UNIQUE KEY emp_email_uk (email),
  KEY emp_dept_fk (department_id),
  KEY emp_job_fk (job_id),
  KEY emp_manager_fk (manager_id),
  CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES Departments (department_id),
  CONSTRAINT emp_job_fk FOREIGN KEY (job_id) REFERENCES Jobs (job_id),
  CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES Employees (employee_id)
); 



--
-- Table structure for table Job_history
--

DROP TABLE Job_history;

CREATE TABLE Job_history (
  employee_id int NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  job_id varchar(10) NOT NULL,
  department_id int DEFAULT NULL,
  PRIMARY KEY (employee_id,start_date),
  KEY jhist_job_fk (job_id),
  KEY jhist_dept_fk (department_id),
  CONSTRAINT jhist_job_fk FOREIGN KEY (job_id) REFERENCES Jobs (job_id),
  CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES Employees (employee_id),
  CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES Departments (department_id)
);




--
-- Table structure for table `Jobs`
--

DROP TABLE Jobs;

CREATE TABLE Jobs (
  job_id varchar(10) NOT NULL,
  job_title varchar(35) NOT NULL,
  min_salary int DEFAULT NULL,
  max_salary int DEFAULT NULL,
  PRIMARY KEY (job_id)
);



--
-- Table structure for table `Locations`
--

DROP TABLE Locations;

CREATE TABLE Locations (
  location_id int NOT NULL,
  street_address varchar(40) DEFAULT NULL,
  postal_code varchar(12) DEFAULT NULL,
  city varchar(30) NOT NULL,
  state_province varchar(25) DEFAULT NULL,
  country_id char(2) DEFAULT NULL,
  PRIMARY KEY (location_id),
  KEY loc_c_id_fk (country_id),
  CONSTRAINT loc_c_id_fk FOREIGN KEY (country_id) REFERENCES Countries (country_id)
);



--
-- Table structure for table `Regions`
--

DROP TABLE Regions;

CREATE TABLE Regions (
  region_id int NOT NULL,
  region_name varchar(25) DEFAULT NULL,
  PRIMARY KEY (region_id)
); 




--@dataForHR