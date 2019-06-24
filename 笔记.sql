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


