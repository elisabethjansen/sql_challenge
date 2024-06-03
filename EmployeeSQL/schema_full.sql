CREATE TABLE Departments (
    "dept_no" VARCHAR(15) PRIMARY KEY NOT NULL,
    "dept_name" VARCHAR(50) NOT NULL
);

CREATE TABLE Titles (
    "title_id" VARCHAR(15) PRIMARY KEY NOT NULL,
    "title" VARCHAR(50)
);

CREATE TABLE Employees (
    "emp_no" VARCHAR(15) PRIMARY KEY NOT NULL,
    "emp_title_id" VARCHAR(15),
    "birth_date" DATE,
    "first_name" VARCHAR(15),
    "last_name" VARCHAR(50),
    "sex" VARCHAR(15),
    "hire_date" DATE,
    FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id)
);

CREATE TABLE Dept_emp (
    "emp_no" VARCHAR(15),
    "dept_no" VARCHAR(15),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

CREATE TABLE Dept_manager (
    "dept_no" VARCHAR(15),
    "emp_no" VARCHAR(15),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

CREATE TABLE Salaries (
    "emp_no" VARCHAR(15),
    "salary" INT,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);


--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM Employees e
JOIN Salaries s ON e.emp_no=s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986. (Using YEAR() function not recognized)
SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date::text LIKE '1986%';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT m.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM Dept_manager m
JOIN Departments d ON m.dept_no = d.dept_no
JOIN Employees e ON m.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT d.dept_no, e.emp_no, e.first_name, e.last_name, n.dept_name
FROM Employees e
JOIN Dept_emp d ON e.emp_no = d.emp_no
JOIN Departments n ON d.dept_no = n.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM Employees
WHERE 
	first_name = 'Hercules'
	AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM Employees e
JOIN Dept_emp d ON e.emp_no = d.emp_no
JOIN Departments n ON n.dept_no = d.dept_no
WHERE d.dept_no IN (
	SELECT dept_no
	FROM Departments
	WHERE LOWER(dept_name) = 'sales'
);

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, n.dept_name
FROM Employees e
JOIN Dept_emp d ON e.emp_no = d.emp_no
JOIN Departments n ON n.dept_no = d.dept_no
WHERE d.dept_no IN (
	SELECT dept_no
	FROM Departments
	WHERE LOWER(dept_name) IN ('sales', 'development')
);

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "Last Name"
FROM Employees
GROUP BY last_name
ORDER BY "Last Name" DESC;
