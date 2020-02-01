-- 1.List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary 
FROM employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no;

-- 2.List employees who were hired in 1986.
SELECT emp_no, last_name, first_name, gender, hire_date 
FROM employees
WHERE (SELECT EXTRACT(YEAR FROM "hire_date")) = 1986;

-- 3.List the manager of each department with the following information: department number, 
-- department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, e.hire_date start_employment_date, t.to_date end_employment_date
FROM departments d
LEFT JOIN dept_manager dm
ON d.dept_no = dm.dept_no
LEFT JOIN employees e
ON dm.emp_no = e.emp_no
LEFT JOIN titles t
ON dm.emp_no = t.emp_no
WHERE t.title = 'Manager' and t.to_date = '9999-01-01'
ORDER BY d.dept_no;

-- 4.List the department of each employee with the following 
-- information: employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
LEFT JOIN (
	SELECT emp_no, max(to_date) max_to_date
	FROM dept_emp
	GROUP BY emp_no) de1
ON e.emp_no = de1.emp_no
LEFT JOIN dept_emp de
ON de1.emp_no = de.emp_no AND de1.max_to_date = de.to_date
LEFT JOIN departments d
ON de.dept_no = d.dept_no;

-- 5.List all employees whose first name is "Hercules" and last names begin with "B."

SELECT *
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
LEFT JOIN employees e
ON de.emp_no = e.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no
WHERE de.to_date > CURRENT_DATE AND d.dept_name = 'Sales';

-- 7.List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
LEFT JOIN employees e
ON de.emp_no = e.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no
WHERE de.to_date > CURRENT_DATE AND d.dept_name IN ('Sales', 'Development');

-- 8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, count(last_name) as count_ln
FROM employees
GROUP BY last_name
ORDER BY count_ln DESC;

-- Epilogue

SELECT *
FROM employees
WHERE emp_no = 499942;