CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" Integer   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" Integer   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" Integer   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "sex" VARCHAR(2)   NOT NULL,
    "hire_date" DATE   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" Integer   NOT NULL,
    "salary" integer   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR (10)   NOT NULL,
    "title" VARCHAR (20)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    s.salary
FROM
    employees e
JOIN
    salaries s ON e.emp_no = s.emp_no;
	
SELECT
    first_name,
    last_name,
    hire_date
FROM
    employees
WHERE
    EXTRACT(YEAR FROM hire_date) = 1986;
	
SELECT
    d.dept_no,
    d.dept_name,
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    departments d
JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
JOIN
    employees e ON dm.emp_no = e.emp_no;

SELECT
    de.dept_no,
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no;

SELECT
    first_name,
    last_name,
    sex
FROM
    employees
WHERE
    first_name = 'Hercules'
    AND last_name LIKE 'B%';

SELECT
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Sales';
	
SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');

SELECT
    last_name,
    COUNT(*) AS "# of employees having the same last name"
FROM
    employees
GROUP BY
    last_name
ORDER BY
    "# of employees having the same last name" DESC;