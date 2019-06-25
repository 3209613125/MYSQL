删除数据库，在C盘的 C:\ProgramData里，
注意这是隐藏文件，在Program后面添加Data，打开MYSQL:\data文件里可以看到已经创建的库



delete from emploee where id=3;  //删行

alter table emploee add primary key(id);

create database d2 default char set utf8  default collate utf8_bin;

//desc +表名(不能是库名);

//`` 用于在mysql中关键字命名，java不能用关键字命名

show create table;

select * from table名 where id=3;


truncate delete
区别：
delete:1.可以根据条件删除部分数据
2.可以删除整个表的数据，返回删除的记录数
3.相对truncate速度慢
4.不会重置auto_increment的值
5.表结构两者都在


truncate：
1.只能删除整个表的数据
2.效率比较高，mysql内部不会操作数据
3.重置auto_increment的值


优先使用truncate、

insert into emp2 select * from emp

再mysql中关键字要用` `(反引号括起来)，例如:
create database `database`;

还原命令:
mysqldump -uroot -p -B java8 >d:/java8.sql

mysql中存在多种格式的utf8编码，其中最常见的两种为:
1.utf8_bin
1.utf8_general_ci 不区分大小写

create database if not exists java8

create database db1 charset=utf8


create table hhh(
id int,
name varchar(32),
gender varchar(2)
)


insert into hhh(id,name,gender) values (1,'jack','男')



9.显示人名字和部门名称


emp dept
select emp.ename,dept.dname from emp,dept where emp.deptno = dept.deptno;   --内连接
select emp.ename,dept.dname from inner join dept on emp.deptno = dept.deptno;  -- 内连接的标准写法

左连接和右连接：（哪边完全显示就是什么连接）
编号 名称 班级          编号   名称
1   张三    java1        java1    java北郊

查询所有学生的成绩，如果没有也要显示出来
将学生表放在左边，没有也能显示出来
左右可以互换：左换右，表换表；右换左，右表换左表（特点）


innodb不支持全索引
memory：支持btree，支持hashindex


10.
索引：不加内存，不改程序，不调sql，可以提高查询速度成百上千倍，查询速度的提高前提是牺牲了插入，
更新，删除的速度为代价的，这些写操作，增加了大量的io，所以它的价值，在于提高海量数据的检索速度

常见索引分为：主键索引（primary key），唯一索引（unique），普通索引（index），全文索引（fulltext）--解决中子索引的问题

案例：先整一个海量表，在查询的时候，看看索引问题
构建模拟一个8000000条记录的数据

delimiter ;

&&意味着开始和结束   ，procedure过程，call为调用函数的意思 select * from 表 add index（depton);

主键索引:
primary key，主键本身就是一个索引，主键可以指定多列
唯一索引：unique = unique key

普通索引：前两种添加方式，会自动把列名作为索引名字，而第三种会手动添加，因为索引是隶属于某个表的，所以必须首先告诉是在哪一个表的，否则就会像前两种一样自动将列认为索引名字，
而非手动指定    特点：可以有多个，即区别于主键索引额和唯一索引的唯一性（不能有多个）

