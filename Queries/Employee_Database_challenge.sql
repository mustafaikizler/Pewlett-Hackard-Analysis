-- Deliverable 1
SELECT e.emp_no, e.first_name, e.last_name,
		ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

select * from retirement_titles
select count(emp_no) from retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title	
	INTO unique_titles
	FROM retirement_titles
	WHERE (to_date = '9999-01-01')
	ORDER BY emp_no, to_date DESC;
	

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY(title)
ORDER BY (count) desc

Select * from retiring_titles


-- Deliverable 2: 
-- The Employees Eligible for the Mentorship Program

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
ORDER BY(e.emp_no)



-- DELIVERABLE 3

-- Mentorship eligibility by department
select  count(emp_no) ,title 
from mentorship_eligibility
Group by title


-- Current employees By Title
SELECT DISTINCT ON (ce.emp_no) ce.emp_no, ce.first_name, ce.last_name, ti.title
INTO current_emp_title
from current_emp as ce
left join titles as ti
ON (ce.emp_no = ti.emp_no)
ORDER BY(emp_no);
SELECT COUNT(emp_no), title FROM current_emp_title
GROUP BY title
ORDER BY(count) desc;


-- Retirement salary by title

SELECT ut.emp_no, ut.title, sa.salary
INTO retirement_salary_left
FROM unique_titles AS ut
left JOIN salaries as sa
ON (ut.emp_no = sa.emp_no)
ORDER BY (ut.emp_no)

SELECT AVG(SALARY), title from retirement_salary_left GROUP BY title

SELECT * from retirement_salary_left
SELECT FORMAR(avg) from









