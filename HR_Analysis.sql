CREATE DATABASE hr_analysis;
USE hr_analysis;
CREATE TABLE employees (Employee_ID INT PRIMARY KEY,Employee_Name VARCHAR(100),Gender VARCHAR(20), Age INT,
    Department VARCHAR(50),Job_Role VARCHAR(100), Salary DECIMAL(10,2),Experience_Years INT, Joining_Date DATE,
    Education VARCHAR(50), Performance_Rating INT,Job_Satisfaction INT,Overtime VARCHAR(10), Attrition VARCHAR(10));
SELECT * FROM employees;

SELECT COUNT(*) AS Total_Employees FROM employees;
SELECT DISTINCT Department FROM employees;

/*Which department has the large no. of Employees */
SELECT Department,COUNT(*) AS Employee_Count FROM employees GROUP BY Department ORDER BY Employee_Count DESC;

/*Employees earning more than ₹60,000*/
SELECT Employee_Name, Department, Salary FROM employees WHERE Salary > 60000 ORDER BY Salary DESC;

/*Employees with high performance*/
SELECT Employee_Name, Department, Performance_Rating FROM employees WHERE Performance_Rating >= 4; 

/*Employees with more than 5 years of experience*/
SELECT Employee_Name, Experience_Years FROM employees WHERE Experience_Years > 5 ORDER BY Experience_Years DESC;

/*Top 10 highest-paid employees*/
SELECT Employee_Name, Department,Job_Role, Salary FROM employees ORDER BY Salary DESC LIMIT 10;

SELECT AVG(Salary) AS Average_Salary FROM employees;
SELECT MAX(Salary) AS Maximum_Salary,  MIN(Salary) AS Minimum_Salary FROM employees;
SELECT Department, AVG(Salary) AS Average_Salary FROM employees GROUP BY Department ORDER BY Average_Salary DESC;

/*Categorise the salary*/
SELECT Employee_Name, Salary, CASE
        WHEN Salary >= 80000 THEN 'High Salary'
        WHEN Salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS Salary_Category FROM employees;
    
/* Tells how many employees have stayed and how many left*/
SELECT Attrition, COUNT(*) AS Employee_Count FROM employees GROUP BY Attrition;

/* Attrition Rate and round off to 2 digit */
SELECT ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate FROM employees;

/* Employees earning more than avg salary*/
SELECT Employee_Name, Department, Salary FROM employees WHERE Salary > ( SELECT AVG(Salary)FROM employees) ORDER BY Salary DESC;

CREATE TABLE departments ( Department_ID INT PRIMARY KEY, Department VARCHAR(50), Manager_Name VARCHAR(100), Location VARCHAR(100));
INSERT INTO departments (Department_ID, Department, Manager_Name, Location) VALUES(101, 'IT', 'Vivek More', 'Pune'),
                                                                                  (102, 'HR', 'Riya Gupta', 'Mumbai'),
																				  (103, 'Finance', 'Meera Nair', 'Pune'),
                                                                                  (104, 'Sales', 'Aditya Pawar', 'Mumbai'),
																				  (105, 'Marketing', 'Aditi Singh', 'Pune');
Select * from departments;

SELECT e.Employee_Name, e.Department, d.Manager_Name FROM employees e LEFT JOIN departments d ON e.Department = d.Department;

SELECT e.Employee_Name, e.Department, d.Manager_Name FROM employees e INNER JOIN departments d ON e.Department = d.Department WHERE e.Department = 'IT';

SELECT Employee_Name, Department, Salary, RANK() OVER ( ORDER BY Salary DESC) AS Salary_Rank FROM employees;
