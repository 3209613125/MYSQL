语法:
CREATE DATABASE [IF NOT EXISTS] db_name [create_specification [, create_specification]
...]
create_specification:
[DEFAULT] CHARACTER SET charset_name
[DEFAULT] COLLATE collation_name

大写的表示关键字
[] 是可选项
CHARACTER SET: 指定数据库采用的字符集
COLLATE: 指定数据库字符集的校验规则

创建库:

创建名为 db1 的数据库
create database db1;

说明：当我们创建数据库没有指定字符集和校验规则时，系统使用默认字符集：utf8，校验规则是：utf8_
general_ ci

说明：当我们创建数据库没有指定字符集和校验规则时，系统使用默认字符集：utf8，校验规则是：utf8_
general_ ci

创建一个使用utf8字符集的 db2 数据库
create database db2 charset=utf8;
