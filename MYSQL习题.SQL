题目描述
查找薪水涨幅超过15次的员工号emp_no以及其对应的涨幅次数t
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
输入描述:
无
输出描述:
emp_no	t

10001

17

10004

16

10009
             
             
--分组查询并过滤
select emp_no , count(*) as t
from salaries
group by emp_no
having t>15;

             
             
             
------------------------------------------------------------------------------------------
获取所有部门当前manager的当前薪水情况，给出dept_no, emp_no以及salary，当前表示to_date='9999-01-01'
CREATE TABLE `dept_manager` (
`dept_no` char(4) NOT NULL,
`emp_no` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
输入描述:
无
输出描述:
dept_no	emp_no	salary

d001

10002

72527

d004

10004

74057

d003

10005

94692

d002

10006

43311

d006

10010

94409
             
             
             
--多表查询
select m.dept_no,m.emp_no,s.salary
from
dept_manager as m,
salaries as s
where m.emp_no = s.emp_no
and s.to_date='9999-01-01'
and m.to_date='9999-01-01'


-------------------------------------------------------------------------------
编写一个 SQL 查询，获取 Employee 表中第 n 高的薪水（Salary）。

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
例如上述 Employee 表，n = 2 时，应返回第二高的薪水 200。如果不存在第 n 高的薪水，那么查询应返回 null。


 set N=N-1;
 select distinct salary from Employee order by salary desc limit 1 offset N;
