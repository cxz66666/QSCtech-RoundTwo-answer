create database backend;
use backend;
create table students
(
	id int auto_increment,
	name varchar(50) not null,
	age int not null,
	gender int not null,
	current_class varchar(255) not null,
	freshman_class varchar(255) null,
	zju_id bigint not null,
	constraint students_pk
		primary key (id)
);

create unique index students_zju_id_uindex
	on students (zju_id);

insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('name1',20,1,'计算机科学','工信1901',3190100000);
insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('小明',24,1,'生物医学工程','工信1902',3190100015);
insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('小红',41,0,'电器维修','工信1903',3190100034);
insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('小粉',50,0,'自动化','工信1904',3190100075);
insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('封天詹皇',1,1,'控制','工信1905',3190100023);
insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('李青',31,1,'计算机科学','工信1906',3190100011);
insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('末日铁拳',25,0,'计算机科学','工信1905',3190100047);
insert into students ( name, age, gender, current_class, freshman_class, zju_id) values ('凯瑞甘',100,1,'计算机科学','工信1902',3190100086);