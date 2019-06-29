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
