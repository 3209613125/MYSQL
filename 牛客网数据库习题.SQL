对于表actor批量插入如下数据
CREATE TABLE IF NOT EXISTS actor (
actor_id smallint(5) NOT NULL PRIMARY KEY,
first_name varchar(45) NOT NULL,
last_name varchar(45) NOT NULL,
last_update timestamp NOT NULL DEFAULT (datetime('now','localtime')))

actor_id	first_name	last_name	last_update
1        	PENELOPE	  GUINESS	  2006-02-15 12:34:33
2	        NICK	      WAHLBERG	2006-02-15 12:34:33

-- 方法一：
insert into actor (actor_id, first_name, last_name, last_update)
values
(1, 'PENELOPE', 'GUINESS', '2006-02-15 12:34:33'),
(2, 'NICK', 'WAHLBERG','2006-02-15 12:34:33');
-- 方法二：
insert into actor values (1,'PENELOPE','GUINESS','2006-02-15 12:34:33'), (2,'NICK','WAHLBERG','2006-02-15
12:34:33');

------------------------------------------------------------------------------------------------------------

找出所有员工当前(to_date='9999-01-01')具体的薪水salary情况，对于相同的薪水只显示一次,并按照逆序显示
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));

-- 方法一：
select salary from salaries where to_date = '9999-01-01' group by salary order by salary desc;
-- 方法二：
select distinct salary from salaries where to_date='9999-01-01' order by salary desc;

------------------------------------------------------------------------------------------------------------

查找最晚入职员工的所有信息
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
输入描述:
无
输出描述:
emp_no	birth_date	first_name	last_name	gender	hire_date

10008

1958-02-19

Saniya

Kalloufi

M

1994-09-15

方法1:
select * from employees order by hire_date desc limit 1;
方法2:
select * from employees where hire_date = (select max(hire_date) from employees);
方法3:
select * from employees order by hire_date desc limit 1 offset 0;
方法4:
select * from employees order by hire_date desc limit 0,1;

-------------------------------------------------------------------------------------------------------------
查找入职员工时间排名倒数第三的员工所有信息

方法1：
select * from employees order by hire_date desc limit 2,1;

方法二：
select * from employees order by hire_date desc limit 1 offset 2;
--------------------------------------------------------------------------------------------------------------
查找薪水涨幅超过15次的员工号emp_no以及其对应的涨幅次数t
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));

select emp_no ,count(emp_no) as t from salaries group by emp_no having t > 15;
---------------------------------------------------------------------------------------------------------------
获取所有部门当前manager的当前薪水情况，给出dept_no, emp_no以及salary，当前表示to_date='9999-01-01'

--多表查询
select m.dept_no,m.emp_no,s.salary from dept_manager as m ,salaries as s
where m.emp_no = s.emp_no and m.to_date = '9999-01-01'and s.to_date = '9999-01-01';
---------------------------------------------------------------------------------------------------------------
从titles表获取按照title进行分组，每组个数大于等于2，给出title以及对应的数目t。

select title ,count(title) as t from titles group by title having t >= 2;
---------------------------------------------------------------------------------------------------------------
编写一个 SQL 查询，查找 Person 表中所有重复的电子邮箱。

select Email from Person group by Email having count(Email) > 1;
--------------------------------------------------------------------------------------------------------------
如果一个国家的面积超过300万平方公里，或者人口超过2500万，那么这个国家就是大国家。

编写一个SQL查询，输出表中所有大国家的名称、人口和面积。

例如，根据上表，我们应该输出:

select name,population,area from World where population > 25000000 or area > 3000000;

select name,population,area from World where population > 25000000 union select name,population,area from World where area > 3000000;
---------------------------------------------------------------------------------------------------------------
编写一个 SQL 查询，获取 Employee 表中第 n 高的薪水（Salary）。

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
例如上述 Employee 表，n = 2 时，应返回第二高的薪水 200。如果不存在第 n 高的薪水，那么查询应返回 null。

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
set N = N-1;
  RETURN (
      # Write your MySQL query statement below.
     select distinct salary from Employee order by salary desc limit 1 offset N
      
  );
END
------------------------------------------------------------------------------------------------------------
查找字符串'10,A,B' 中逗号','出现的次数cnt。

select length('10,A,B')-length(replace('10,A,B',',',''));
------------------------------------------------------------------------------------------------------------查找所有员工入职时候的薪水情况，给出emp_no以及salary， 并按照emp_no进行逆序
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));


select e.emp_no,s.salary
from employees as e,salaries as s
where e.emp_no=s.emp_no
and e.hire_date=s.from_date
order by e.emp_no desc;

