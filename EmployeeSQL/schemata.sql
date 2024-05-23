-- Drop all 6 tables if they already exist to prevent errors
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS titles;

-- Create the "titles" table
CREATE TABLE titles (
    title_id VARCHAR(5) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

-- Import data from "titles.csv" into the "titles" table
COPY titles(title_id, title) 
FROM 'C:\data\titles.csv'
DELIMITER ',' CSV HEADER;

-- Create the "employees" table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR(1) NOT NULL CHECK (sex IN ('M', 'F')),
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Import data from "employees.csv" into the "employees" table
COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date) 
FROM 'C:\data\employees.csv' 
DELIMITER ',' CSV HEADER;

-- Create the "departments" table
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Import data from "departments.csv" into the "departments" table
COPY departments(dept_no, dept_name) 
FROM 'C:\data\departments.csv' 
DELIMITER ',' CSV HEADER;

-- Create the "dept_manager" table
CREATE TABLE dept_manager (
    dept_manager_id SERIAL PRIMARY KEY,
    dept_no CHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Import data from "dept_manager.csv" into the "dept_manager" table
COPY dept_manager(dept_no, emp_no) 
FROM 'C:\data\dept_manager.csv' 
DELIMITER ',' CSV HEADER;

-- Create the "dept_emp" table
CREATE TABLE dept_emp (
    dept_emp_id SERIAL PRIMARY KEY,
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Import data from "dept_emp.csv" into the "dept_emp" table
COPY dept_emp(emp_no, dept_no) 
FROM 'C:\data\dept_emp.csv' 
DELIMITER ',' CSV HEADER;

-- Create the "salaries" table
CREATE TABLE salaries (
    salary_id SERIAL PRIMARY KEY,
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Import data from "salaries.csv" into the "salaries" table
COPY salaries(emp_no, salary) 
FROM 'C:\data\salaries.csv' 
DELIMITER ',' CSV HEADER;