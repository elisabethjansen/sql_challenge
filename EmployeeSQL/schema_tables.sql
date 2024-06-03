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