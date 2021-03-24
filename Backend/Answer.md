

# Back End, Let's Go!



### 1-1 数据库初始化

**数据库选择为mysql社区版**

登录

~~~mysql
mysql -uroot -p
passwd
~~~

![image-20210320231423926](https://pic.raynor.top/images/2021/03/20/image-20210320231423926.png)

查询版本

![image-20210320231511545](https://pic.raynor.top/images/2021/03/20/image-20210320231511545.png)



### 1-2 建表并添加记录

~~~mysql
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
~~~

![image-20210320233535537](https://pic.raynor.top/images/2021/03/20/image-20210320233535537.png)

![image-20210321134137465](https://pic.raynor.top/images/2021/03/21/image-20210321134137465.png)



### 2-1 配置 Go 语言环境

![image-20210320233626774](https://pic.raynor.top/images/2021/03/20/image-20210320233626774.png)



### 2-2 新建 Go 语言项目

#### ![image-20210321093118750](https://pic.raynor.top/images/2021/03/21/image-20210321093118750.png)



### 3-1 使用 GORM 提供的驱动连接到数据库

这里我将配置写到config.json文件内，同时主函数读取该文件并进行连接

~~~go
func getDbConfig()(DbConfig, bool){
	var data, err = ioutil.ReadFile(configFile) //read config file
	if err!=nil{
		println(err)
		return  DbConfig{}, false
	}
	config:=DbConfig{}
	err = json.Unmarshal(data, &config)

	if err!=nil{
		println(err)
		return DbConfig{}, false
	}
	return config,true
}

func main(){
    //........... something else
    dsn:=fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True&loc=Local",
	config.Username,config.Password,config.Host,config.Port,config.Dbname)
	//dsn := "user:pass@tcp(127.0.0.1:3306)/dbname?charset=utf8mb4&parseTime=True&loc=Local"
	println(dsn)
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
    //.............something else
}
~~~

### 3-2 利用 ORM 思想与数据库进行交互

~~~go
func solveProblem(db *gorm.DB) {
	stuCreate:=Student{Name: "ChenXuzheng",Age: 20,Gender: 1,CurrentClass: "计算机科学",FreshmanClass: "工信",ZjuId: 1111111111}
	db.Create(&stuCreate)
	println("Create finished!")

	stuXiaozhang:=Student{}
	db.Where("name = ?","小张").First(&stuXiaozhang)
	println("The zjuid of xiaozhang is ",stuXiaozhang.ZjuId)

	stuAgeAbove19:=[]Student{}
	db.Where("age > ?",19).Find(&stuAgeAbove19)
	print("Following are the names of stu who age above 19\n")
	for _,val := range stuAgeAbove19{
		print(val.Name," ")
	}
	print("\n")

	db.Delete(&stuCreate)
	println("Delete complete")

}
~~~

运行结果如图

![image-20210321142626556](https://pic.raynor.top/images/2021/03/21/image-20210321142626556.png)





附件

- 1-2.sql
- Go-Backend文件夹

