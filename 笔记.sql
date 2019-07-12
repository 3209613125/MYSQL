删除数据库，在C盘的 C:\ProgramData里，
注意这是隐藏文件，在Program后面添加Data，打开MYSQL:\data文件里可以看到已经创建的库


select database();查询当前数据库   select user();查看用户信息    
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


11.事物管理
一条业务成功影响与之相关的下一条语句是否成功，如果第一条相关语句失败，那么第二条也不会成功  eg:张三-500,李四+500


一票多卖怎么解决，在两个人app上，不能用syngonize，如果票数为1，买完后把数据库票数由1变为0，如果更新数据时发现票数为0，则不能更新，说明数据已经被他人修改，在实际中则是控制版本更新

update account set balance=balance-50 where id=2;

凡是生产数据库，都要先开启事务，但并不是所有引擎都支持，默认innodb引擎支持
开启事务: start transcation
savepoint xx
rollback to xx
rollback
commit

如果没有设置保存点，也可以rollback，但只能回滚到事务开始
InnoDB支持事务，My0ISAM不支持事务


事务的隔离级别:
当两个人对某一张表同时开启事务，需要保证事务的一致性，当一个人修改表的时候，另一个人查询，不会影响

脏读：
当一个事务正被访问且修改，但没被commit，此时另外一个事务也在访问数据，看到并访问了这个数据，这就叫脏读，也就是一个事务读到了另一个事务没有提交的数据

不可重复读：
在一个事务中两次读取数据不一样，也就是没有设置隔离，解决方法：只有在事务完全提交之后才可以读取数据（重在修改值）

幻读：
在事务未被提交之前，两个事务同时修改一个数据，解决方法：重点是新增或删除（重点在于增删）

mysql的默认隔离级别就是 可重复读：
脏读  不可重复读  幻读   加锁读
×           ×             ×     不加锁

事务的ACID特性：
原子性：事务是应用中不可再分的最小逻辑执行体

一致性：数据库只包含事务成功提交的结果时，数据库处于一致性状态。如果中途发生中断，某个事物尚未完成而被迫中断，而改未完成的事物对数据库所做的修改一i就被写入数据库，此时
数据库就处于一个不正确的状态，因此一致性是通过原子性来保证的

隔离性：我们的并发事务之间相互隔离不干扰

持久性：事务一旦被提交，就已成定局不能被改变

视图：是一个虚拟表，其内容是由查询定义，里面包含了列数据和行数据
1.创建视图
create view 视图名 as select语句  作用：由此 筛选出表中 一堆信息中个别有需求的信息，而不是全看，否则select * from 表，结果就全部出来了，保证数据的安全性和查询的简便性
在公司当对接信息时，我们不该给第三发该公司的一整张表，而是给其视图，为了安全性
一般在视图前加上前缀view_  ,因为在查询表时，视图与之并列，由此前缀来区分是视图还是表
视图的修改会影响到基表的变化，基表的修改也会影响到视图

删除视图:
drop view view_

视图的规则和限制:
唯一命名，不能与表明一样
数目无限制，但复杂查询创建为视图之后的性能影响（如有一个查询特别复杂的时候，变为视图的时候，变得比较简单，让你潜意识认为性能很高，然而实际情况是视图背后是一个复杂查询）
视图不能添加索引，依然不能有关联的触发器或者默认值，因为视图是个虚拟的，不占存储空间，而索引要占存储空间
视图可以提高安全性，必须具有足够的访问权限
order by可以用在视图中，但如果从该视图检索数据select中也含有order by，那么该视图中的order by将被覆盖
视图可以和表一起使用

用户管理：
root为根，最高权限



