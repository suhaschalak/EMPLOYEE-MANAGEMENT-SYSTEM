CREATE DATABASE employee_management;
USE employee_management;

CREATE TABLE Jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender CHAR(1),
    hire_date DATE NOT NULL,
    job_id INT,
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO Jobs (job_id, job_title, min_salary, max_salary)
VALUES 
    (3, 'Project Manager', 70000, 150000),
    (4, 'HR Specialist', 40000, 90000),
    (5, 'Marketing Manager', 50000, 120000),
    (6, 'Sales Executive', 45000, 100000);

INSERT INTO Departments (department_id, department_name, manager_id)
VALUES 
    (3, 'Human Resources', NULL),
    (4, 'Marketing', NULL),
    (5, 'Sales', NULL);

INSERT INTO Employees (employee_id, first_name, last_name, date_of_birth, gender, hire_date, job_id, department_id, salary)
VALUES 
    (3, 'Alice', 'Johnson', '1985-05-20', 'F', '2018-09-12', 3, 1, 110000),
    (4, 'Bob', 'Brown', '1979-12-17', 'M', '2017-11-25', 4, 3, 60000),
    (5, 'Charlie', 'Davis', '1992-03-22', 'M', '2021-01-05', 5, 4, 75000),
    (6, 'Diana', 'Miller', '1988-07-11', 'F', '2019-08-30', 6, 5, 55000),
    (7, 'Eve', 'Wilson', '1991-04-15', 'F', '2020-10-20', 1, 1, 95000),
    (8, 'Frank', 'Clark', '1983-02-27', 'M', '2016-06-06', 2, 2, 125000),
    (9, 'Grace', 'Martinez', '1995-01-19', 'F', '2022-02-10', 3, 1, 105000),
    (10, 'Henry', 'Lee', '1987-11-05', 'M', '2023-03-03', 4, 3, 85000),
    (11, 'Ivy', 'Walker', '1990-10-10', 'F', '2021-07-07', 5, 4, 70000),
    (12, 'Jack', 'Hall', '1982-08-18', 'M', '2015-05-14', 6, 5, 98000);

-- List all employees with their department names and job titles.
SELECT e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
JOIN Jobs j ON e.job_id = j.job_id;

-- Find the total number of employees in each department.
SELECT d.department_name, COUNT(e.employee_id) AS num_employees
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Calculate the average salary for each job position
SELECT j.job_title, AVG(e.salary) AS avg_salary
FROM Jobs j
LEFT JOIN Employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

-- Retrieve the details of employees whose salaries are above the average salary.
SELECT e.employee_id, e.first_name, e.last_name, e.salary
FROM Employees e
WHERE e.salary > (SELECT AVG(salary) FROM Employees);


-- Update manager information for a department
UPDATE Departments
SET manager_id = 3
WHERE department_id = 1;

-- Give a raise of 10% to all employees in a specific department
UPDATE Employees
SET salary = salary * 1.10
WHERE department_id = 2;

-- Delete employees who are no longer with the company
DELETE FROM Employees
WHERE employee_id = 12;

SELECT * FROM jobs;
SELECT * FROM Departments;
SELECT * FROM Employees;

