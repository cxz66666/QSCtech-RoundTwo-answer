package main

import (
	"encoding/json"
	"fmt"
	 "io/ioutil"
)
import (
	"gorm.io/gorm"
	"gorm.io/driver/mysql"
)


type DbConfig struct {
	Username string `json:username`
	Password string `json:password`
 	Host string		`json:host`
	Port int		`json:port`
	Dbname string	`json:dbname`
}

type Student struct {
	ID uint  `gorm:"column:id"`
	Name string `gorm:"column:name"`
	Age int `gorm:"column:age"`
	Gender int `gorm:"column:gender"`
	CurrentClass string `gorm:"column:current_class"`
	FreshmanClass string `gorm:"column:freshman_class"`
	ZjuId int64 `gorm:"column:zju_id"`
}

const configFile="config.json" //the config file name

func main() {
	fmt.Println("Begin read the config")
	config,dberr:=getDbConfig()
	if(!dberr){
		println("Can't open config file, please check and retry");
	}
	dsn:=fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		config.Username,config.Password,config.Host,config.Port,config.Dbname)
	//dsn := "user:pass@tcp(127.0.0.1:3306)/dbname?charset=utf8mb4&parseTime=True&loc=Local"
	println(dsn)
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err!=nil{
		println(err)
	}
	solveProblem(db);
}

func solveProblem(db *gorm.DB) {
	stuCreate:=Student{Name: "ChenXuzheng",Age: 20,Gender: 1,CurrentClass: "计算机科学",FreshmanClass: "工信",ZjuId: 1111111111}
	db.Create(&stuCreate)  //create the student record
	println("Create finished!")

	stuXiaozhang:=Student{}
	db.Where("name = ?","小张").First(&stuXiaozhang) //select the student which name is xiaozhang
	println("The zjuid of xiaozhang is ",stuXiaozhang.ZjuId)

	stuAgeAbove19:=[]Student{}
	db.Where("age > ?",19).Find(&stuAgeAbove19)  //select the students which age above 19
	print("Following are the names of stu who age above 19\n")
	for _,val := range stuAgeAbove19{
		print(val.Name," ")
	}
	print("\n")

	db.Delete(&stuCreate)   //delete the student which created
	println("Delete complete")

}

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