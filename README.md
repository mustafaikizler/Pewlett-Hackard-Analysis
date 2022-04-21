# Pewlett-Hackard-Analysis
## Overview of The Analysis
Main Purpose of th analysis is by using over 15 CSV files, joining with inner or left join method, identifying the retiring employees by department, title or their birth_date. According the results, we wanted to identify eligible employees for mentorship Program which aims mentorship to new employees.

## Results
- Creating a retirement_title table by joining all employees list with title list, under filter of (1952-01-01' AND '1955-12-31') birth date. The purpose was the bringing the title next to retiring employees table.
  ``` 
  SELECT e.emp_no, e.first_name, e.last_name,
		ti.title, ti.from_date, ti.to_date
  INTO retirement_titles

  FROM employees as e
  LEFT JOIN titles as ti
  ON (e.emp_no = ti.emp_no)
  WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  ORDER BY emp_no
  ``` 
  
 - Single employees had multiple titles over year, In order to identify their latest title, we created a unique_titles list. Especially in this step we used _DISTINCT ON_ function to retrieve only one row with employees' current title (we used the Distinct ON function on unique _employee number_. also we filtered the list with a date that gives us current employees.
 
``` 
  SELECT DISTINCT ON (emp_no) emp_no,
	  first_name,
	  last_name,
	  title
	
    INTO unique_titles
    FROM retirement_titles
    WHERE (to_date = '9999-01-01')
    ORDER BY emp_no, to_date DESC;
``` 
- Next step is the finding the retiring employee number by their title. By doing this we will be able to plan our future hiring strategy according to titles.
We use _COUNT_ funtion to count retiring employees' titles, used _GROUP BY_ to groupe them by title and sort them on decending order on number of titles.  
``` 
  SELECT COUNT(title), title
  INTO retiring_titles
  FROM unique_titles
  GROUP BY(title)
  ORDER BY (count) desc
``` 
- As a last step we wanted to retrieve employees who are eligible for Mentorship Program by their Employee no, first name, last name, birth date, starting date and retirement date, titles. We used inner join among _employees_, _titles_, _department employees_ chart in order to collect only matching dataes from 3 tables, on filer of current employees (```WHERE (de.to_date = '9999-01-01' ```) with birth year 1965 (``` e.birth_date BETWEEN '1965-01-01' AND '1965-12-31' ```)

```
SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, 
		e.last_name, e.birth_date, 
		de.from_date, de.to_date, 
		ti.title
  INTO mentorship_eligibility
  FROM employees AS e
  INNER JOIN dept_emp AS de 
  ON (e.emp_no =  de.emp_no)
  INNER JOIN titles AS ti
  ON (e.emp_no = ti.emp_no)
  WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
  ORDER BY(emp_no)
```
## SUMMARY
- ### How many roles will need to be filled as the "silver tsunami" begins to make an impact?

![image](https://user-images.githubusercontent.com/98247252/164299969-abe863c9-7dfe-40be-9182-286de09e257c.png)

In total 7 titles and 72458 employees' place need to be filled before silver tsunami. 

- ### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

![image](https://user-images.githubusercontent.com/98247252/164321608-9cd7ff57-7044-4f35-b961-f1a3bd104d9b.png)
Number of Emplooyees Who eligible for mentorship by title

![image](https://user-images.githubusercontent.com/98247252/164333254-3630fc85-6beb-4f51-ae4b-0ffc61c8afb8.png)
Number of employees (current employees) by title

I merged current_emp and titles tables by left join and reached the current employees by title. And According to two tables abo, Company PH needs more assits on Senior Staff and Engineer mentorship in order to train new employees before the silver tsunami.
```
SELECT DISTINCT ON (ce.emp_no) ce.emp_no, ce.first_name, ce.last_name, ti.title
INTO current_emp_title
from current_emp as ce
left join titles as ti
ON (ce.emp_no = ti.emp_no)
ORDER BY(emp_no);
SELECT COUNT(emp_no), title FROM current_emp_title
GROUP BY title
ORDER BY(count) desc;
```

The chart below shows  average salaries by title for retiring employees, we cannot see significant difference between titles that we can benefit from the silver tsunami and can hire new assistant engineers with low salary.


![image](https://user-images.githubusercontent.com/98247252/164358680-75e1e74f-13f7-40cd-96e9-7b2ed94fda1d.png)


```
SELECT ut.emp_no, ut.title, sa.salary
INTO retirement_salary_left
FROM unique_titles AS ut
left JOIN salaries as sa
ON (ut.emp_no = sa.emp_no)
ORDER BY (ut.emp_no)

SELECT AVG(SALARY), title from retirement_salary_left GROUP BY title

SELECT * from retirement_salary_left
SELECT FORMAR(avg) from
```
