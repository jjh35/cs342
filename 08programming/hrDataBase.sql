-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hr
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.10.1

DROP TABLE JOB_HISTORY;
DROP TABLE Jobs;
DROP TABLE Departments;
DROP TABLE Employees;

DROP TABLE Locations;
DROP TABLE Countries;
DROP TABLE Regions;

--
-- Table structure for table `Regions`
--


CREATE TABLE Regions (
  region_id int NOT NULL,
  region_name varchar(25) DEFAULT NULL,
  PRIMARY KEY (region_id)
);


--
-- Table structure for table `Countries`
--
CREATE TABLE Countries (
  country_id char(2) Primary Key,
  country_name varchar(40) DEFAULT NULL,
  region_id int DEFAULT NULL
  --FOREIGN KEY (region_id) REFERENCES Regions (region_id) ON DELETE SET NULL
);

 

--
-- Table structure for table `Locations`
--
CREATE TABLE Locations (
  location_id int NOT NULL,
  street_address varchar(40) DEFAULT NULL,
  postal_code varchar(12) DEFAULT NULL,
  city varchar(30) NOT NULL,
  state_province varchar(25) DEFAULT NULL,
  country_id char(2) DEFAULT NULL,
  PRIMARY KEY (location_id)
  --FOREIGN KEY (country_id) REFERENCES Countries (country_id) ON DELETE SET NULL
);

--
-- Table structure for table `Jobs`
--



CREATE TABLE Jobs (
  job_id varchar(10) NOT NULL,
  job_title varchar(35) NOT NULL,
  min_salary int DEFAULT NULL,
  max_salary int DEFAULT NULL,
  PRIMARY KEY (job_id)
);


--
-- Table structure for table `Departments`
--
CREATE TABLE Departments (
  department_id int NOT NULL,
  department_name varchar(30) NOT NULL,
  manager_id int DEFAULT NULL,
  location_id int DEFAULT NULL,
  PRIMARY KEY (department_id)
  --FOREIGN KEY (location_id) REFERENCES Locations (location_id),
  --FOREIGN KEY (manager_id) REFERENCES Employees (employee_id) ON DELETE SET NULL
);

--
-- Table structure for table `Employees`
--


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
  PRIMARY KEY (employee_id)
  --FOREIGN KEY (department_id) REFERENCES Departments (department_id) ON DELETE SET NULL,
  --FOREIGN KEY (job_id) REFERENCES Jobs (job_id) ON DELETE SET NULL,
  --FOREIGN KEY (manager_id) REFERENCES Employees (employee_id) ON DELETE SET NULL
);


--
-- Table structure for table Job_history
--

CREATE TABLE Job_history (
  employee_id int NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  job_id varchar(10) NOT NULL,
  department_id int DEFAULT NULL,
  PRIMARY KEY (employee_id,start_date)
  --FOREIGN KEY (job_id) REFERENCES Jobs (job_id),
  --FOREIGN KEY (employee_id) REFERENCES Employees (employee_id) ON DELETE SET NULL,
  --FOREIGN KEY (department_id) REFERENCES Departments (department_id) ON DELETE SET NULL
);



@dataForHR