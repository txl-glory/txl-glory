# MySQL 数据库备份与还原

备份对于数据库而言是至关重要的。当数据文件发生损坏、MySQL 服务出现错误、系统内核崩溃、计算机硬件损坏或者数据被误删等事件时，使用一种有效的数据备份方案，就可以快速解决以上所有的问题。MySQL 提供了多种备份方案，包括：逻辑备份、物理备份、全备份以及增量备份，你可以选择最适合自己使用的方式备份数据。

物理备份通过直接复制包含有数据库内容的目录与文件实现，这种备份方式适用于对重要的大规模数据进行备份，并且要求实现快速还原的生产环境。典型的物理备份就是复制 MySQL 数据库的部分或全部目录，物理备份还可以备份相关的配置文件。但采用物理备份需要 MySQL 处于关闭状态或者对数据库进行锁操作，防止在备份的过程中改变发送数据。物理备份可以使用 mysqlbackup 对 InnoDB 数据进行备份，使用 mysqlhotcopy 对 MyISAM 数据进行备份。另外，也可以使用文件系统级别的 cp、scp、tar、rsync 等命令。

逻辑备份通过保存代表数据库结构及数据内容的描述信息实现，如，保存创建数据结构以及添加数据内容的 SQL 语句，这种备份方式适用于少量数据的备份与还原。逻辑备份需要查询 MySQL 服务器获得数据结构及内容信息，因为需要查询数据库信息并将这些信息转换为逻辑格式，所以相对于物理备份而言比较慢。逻辑备份不会备份日志、配置文件等不属于数据库内容的资料。逻辑备份的优势在于不管是服务层面、数据库层面还是数据表层面的备份都可以实现，由于是以逻辑格式存储的，所以这种备份与系统、硬件无关。

全备份将备份某一时刻所有的数据，增量备份仅备份某一段时间内发生过改变的数据。通过物理或逻辑备份工具就可以完成完全备份，而增量备份需要开启 MySQL 二进制日志，通过日志记录数据的改变，从而实现增量差异备份。

下面将通过一些案例介绍如何使用 MySQL 提供的工具命令进行逻辑备份。使用 mysqldump 备份数据库，默认该工具会将 SQL 语句信息导出至标准输出，可以通过重定向将输出保存至文件：

1. 备份所有的数据库

mysqldump -u username -ppassword --all-databases > bak.sql

2. 备份指定的数据库 db1、db2 和 db3

mysqldump -u username -ppassword --databases db1 db2 db3 > bak.sql

3. 备份 db 数据库，当仅备份一个数据库时，--databases 可以省略

mysqldump --u username -ppassword db4 > bak.sql

mysqldump -u username -ppassword --databases db4 > bak.sql

两者之间的差别在于不使用 --databases 选项，则备份输出信息中不会包含 CREATE DATABASE 或 USE 语句。不使用 --databases 选项备份的数据文件，在后期进行数据还原操作时，如果该数据库不存在，必须先创建该数据库。

4. 备份 db 数据库指定的表 tb_name1、tb_name2 和 tb_name3

mysqldump -u username -ppassword -t db --tables tb_name1 tb_name2 tb_name3 > bak.sql

注意：mysqldump 默认会将多条插入语句导出成一条 insert 语句格式，不方便查看，如：

insert into t values(1),(2),(3);

如果想导出多条 insert 语句，如：

insert into t values(1);
insert into t values(2);
insert into t values(3);

加上参数 --skip-extended-insert 即可。

mysqldump -u username -ppassword --skip-extended-insert --databases db_name --tables tb_name > tb_name.sql

使用 mysql 命令读取备份文件，实现数据还原功能：

mysql -u username -ppassword < bak.sql

mysql -u username -ppassword db4 < bak.sq1

案例：下面将 testDB 数据库中的内容导出成一个文件，并保存到 /home/目录下

```shell
[root@192 home]# mysqldump -u username -ppassword testDB > /home/bak.sql
```

然后进入 MySQL 数据库，彻底删除 testDB 数据库，然后重新创建 testDB 数据库
将备份的数据导入到刚新建的 testDB 数据库中

```shell
[root@192 home]# mysql -u username -ppassword testDB < /home/bak.sql
```
