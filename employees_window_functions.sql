-- WINDOW FUNCTIONS
-- EMPLOYEES DATASET

select * from employees;

select *, (select avg(salary) from employees) from employees;

select * from employees order by salary desc limit 3;

select * from employees order by department, salary desc;

select *, sum(salary) over() from employees;

select *, count(salary) over() from employees;

select *, row_number() over() from employees;

select *, row_number() over(partition by department) from employees;

select *, row_number() over(partition by department order by salary desc) from employees;

select *, row_number() over(partition by department order by salary asc) from employees;

select *, rank() over(order by salary asc) from employees;

select *, dense_rank() over(order by salary asc) from employees;

-- LAG and LEAD by hire date
select first_name, last_name, department, salary, hire_date,
lag(salary) over(partition by department order by hire_date) as prev_salary,
lead(salary) over(partition by department order by hire_date) as next_salary
from employees;

-- Rank employees by salary within each department
select first_name, last_name, department, salary,
rank() over(partition by department order by salary desc) as dept_rank
from employees;

-- Divide employees into 4 salary buckets per department
select first_name, last_name, department, salary,
ntile(4) over(partition by department order by salary desc) as salary_bucket
from employees;

-- Highest salary in each department for every row
select first_name, last_name, department, salary,
first_value(salary) over(partition by department order by salary desc) as highest_salary
from employees;

-- Lowest salary in each department for every row
select first_name, last_name, department, salary,
last_value(salary) over(partition by department order by salary asc
rows between unbounded preceding and unbounded following) as lowest_salary
from employees;

-- Running total of salary by department
select first_name, last_name, department, salary,
sum(salary) over(partition by department order by hire_date) as running_total
from employees;