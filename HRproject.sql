CREATE DATABASE project1;
USE project1;

-- selecting table for analysis

SELECT *
FROM hrdataprimary;

/*Mywork MNC  has a problem ,some employees could not reach the office
on time in specific cities, need to analyze it and find out wheather
it is caused by interal or external environmental condition
and share the result for this issue
*/

-- checking distinct elements in different fields

SELECT DISTINCT gender
FROM hrdataprimary;

SELECT DISTINCT department
FROM hrdataprimary;

SELECT DISTINCT country
FROM hrdataprimary;

SELECT DISTINCT city
FROM hrdataprimary;

/* conclusion
The company is located in 2 countries
India and United States.
There are total 3 offices in India in
3 different cities namely
mumbai, delhi and hyderbad(this is a spelling error)
There are total 2 offices in United States in
2 different cities namely
new york and dallas
There are total 13 departments and 3 types of gender 
*/

-- data cleaning as there are some spelling errors
UPDATE hrdataprimary
SET city = 'hyderabad'
WHERE city = 'hyderbad';

UPDATE hrdataprimary
SET department = 'accounting'
WHERE department = 'acccunting';

/* conclusion
updated the misspelt elements in 
differnt fields
*/

-- checking if the primary key field has any nulls

SELECT *
FROM hrdataprimary
WHERE Employee_id IS NULL;

/* There is no null value
*/

--number of males in India
SELECT COUNT(gender)
FROM hrdataprimary
WHERE country = 'India' 
AND gender = 'male';

--number of females in India
SELECT COUNT(gender)
FROM hrdataprimary
WHERE country = 'India'
AND gender = 'female';

--number of others in India
SELECT COUNT(gender)
FROM hrdataprimary
WHERE country = 'India' 
AND gender <> 'male'
AND gender <> 'female'

--number of males in United States

SELECT COUNT(gender)
FROM hrdataprimary
WHERE country = 'United States' 
AND gender = 'male';


--number of females in United States

SELECT COUNT(gender)
FROM hrdataprimary
WHERE country = 'United States'
AND gender = 'female';


--number of others in United States

SELECT COUNT(gender)
FROM hrdataprimary
WHERE country = 'United States' 
AND  gender <> 'male'
AND gender <> 'female';

/*conclusion
employees from India
male - 476
female - 269
others - 11
employees from United States
male - 347
female - 257
others - 54
Thus, there is no gender inequaltiy
in both the countries and this cannot
not be the reason
*/

--Analysis by Departments
SELECT DISTINCT Department
FROM hrdataprimary;
-- 12 departments exist in the company


-- number of employees in each department
SELECT COUNT(Employee_id), Department
FROM hrdataprimary
GROUP BY department 

-- number of employees in each department based on gender

--sales

SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'sales'
GROUP BY gender;

--Product Management
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Product Management'
GROUP BY gender;

--Marketing
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Marketing'
GROUP BY gender;

-- Legal
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'legal'
GROUP BY gender;

-- Services
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Services'
GROUP BY gender;

-- Engineering
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Engineering'
GROUP BY gender;

--Training
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Training'
GROUP BY gender;

--Support
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Support'
GROUP BY gender;

--Human Resources
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Human Resources'
GROUP BY gender;

--Research & Development

SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Research and development'
GROUP BY gender;

--Accounting
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Accounting'
GROUP BY gender;

--Business Development
SELECT COUNT(Employee_id), gender
FROM hrdataprimary
WHERE department = 'Business Development'
GROUP BY gender;

/* conclusion
each department has more than 35
employees based on gender,
so there is no chance of any
lonely or boring work life
Thus, this cannot be the reason
*/

--Analysis of salary
--min and max salary by country

SELECT MIN(salary)
FROM hrdataprimary
WHERE country = 'India';

SELECT MAX(salary)
FROM hrdataprimary
WHERE country = 'India';

SELECT MIN(salary)
FROM hrdataprimary
WHERE country = 'United States';

SELECT MAX(salary)
FROM hrdataprimary
WHERE country = 'United States';

--min and max salary based on department

-- sales

SELECT Department, MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'sales'
GROUP BY department

--services

SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'services'
GROUP BY department

--legal
SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'legal'
GROUP BY department

--Enginnering
SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'Engineering'
GROUP BY department

--support
SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'support'
GROUP BY department;

--marketing
SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'marketing'
GROUP BY department;

--training

SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'training'
GROUP BY department;

--Human Resources

SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'Human Resources'
GROUP BY department;

--Research and development
SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'Research and development'
GROUP BY department;

--accounting
SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'accounting'
GROUP BY department;

--business development

SELECT  Department,MIN(salary) as min_salary,
MAX(Salary) as max_salary
FROM hrdataprimary
WHERE department = 'business development'
GROUP BY department;

/* each department has good
pay scale and this cannot be 
the reason
*/


--Average salary on the basis of department

SELECT department, ROUND ( AVG ( salary ),2) AS avg_salary
FROM hrdataprimary
GROUP BY department
ORDER BY  avg_salary DESC;



/* conclusion
The top 3 highest average department 
are Business Development, Legal, training 
*/

/* The director of the company
issued a payraise to every employee
because of high sales during the 
last quater. So need to check the salary
after payraise
*/


 SELECT Employee_id, name, department, city,
	CASE
		WHEN department = 'sales'
		AND city = 'mumbai' OR city = 'dallas'
		THEN salary + (salary * .10)
		WHEN department = 'human resources'
		AND  city = 'mumbai' OR city = 'dallas'
		THEN salary + (salary * .05)
		ELSE salary + (salary * .03)
		END AS payraise
	FROM hrdataprimary;
	
/*conclusion
as the sales were high because of 
sales department, they were given the 
highest raise and other departments got 
the raise too.
*/



/* checking the age of the employees
and commute distance for analysis
*/

--employees who live far away from the office 

SELECT COUNT(employee_id) AS employee, city
FROM hrdataprimary
WHERE age > 50 and commute_distance > 7
GROUP BY city


SELECT COUNT(employee_id) AS employeee, city
FROM hrdataprimary
WHERE age<50 and commute_distance > 10
GROUP BY city


-- employees near by the office 

SELECT COUNT(employee_id) AS employeee, city
FROM hrdataprimary
WHERE age<50 and commute_distance < 10
GROUP BY city;

SELECT COUNT(employee_id) AS employeee, city
FROM hrdataprimary
WHERE age>50 and commute_distance  < 7
GROUP BY city;



/* conclusion
With the data available these are most possible outcomes
and the above outcome outstands.
As most of the offices are located in metropolitan cities
and as we know, these cities have a lot of traffic
this could be the possible reason for our problem.
While there are more than 40 employees who live near by
the office in each city both above and below 50 age and
there are more than 25 employees from each city
whose age is greater than 50 and 
commute distance is more than 7kms
And more than 33 employees whose age is
less than 50 from each city
and commute distance is more than 10kms.
This could be the reason for delay, 
the best course of action would be  to either
increase the travel allowance of the above employees
and make them use the fastest way of transport with the 
provided allowance or allow the above employees 
to work from home, this will not change the 
cost structure of the company too.
*/

--end analysis








