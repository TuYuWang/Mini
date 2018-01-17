//
//  MySql.swift
//  Perfect-App-TemplatePackageDescription
//
//  Created by 涂育旺 on 2018/1/9.
//

import MySQL
import PerfectLogger

class MySql {

    var host: String {
        get {
            return "127.0.0.1"
        }
    }
    
    var port: String {
        get {
            return "3306"
        }
    }
    
    var user: String {
        get {
            return "root"
        }
    }
    
    var password: String {
        get {
            return "456852"
        }
    }
    
    private var mysql: MySQL!
    
    //句柄单例
    private static var instance: MySQL!
    public static func shareInstance(dataBaseName: String) -> MySQL {
        if instance == nil {
            instance = MySql(dataBaseName: dataBaseName).mysql
        }
        return instance
    }
    
    //私有构造器
    private init(dataBaseName: String) {
        self.connectDataBase()
        self.selectDataBase(name: dataBaseName)
    }
    
    //连接数据库
    private func connectDataBase() {
        if mysql == nil {
            mysql = MySQL()
        }
        let connected = mysql.connect(host: "\(host)", user: user, password: password)
        guard connected else {
            LogFile.error(mysql.errorMessage())
            return
        }
        LogFile.info("数据库连接成功")
    }
    
    //选择数据库Scheme
    func selectDataBase(name: String) {
        guard mysql.selectDatabase(named: name) else {
            LogFile.error("数据库选择失败，错误代码:\(mysql.errorCode()) \n 错误描述: \(mysql.errorMessage())")
            return
        }
        LogFile.info("连接Schema: \(name)")
    }
}


let RequestResultSuccess = "SUCCESS"
let RequestResultFailure = "FAILURE"
let ResutlListKey = "list"
let ResuslKey = "result"
let ErrorMessageKey = "errorMessage"
var BaseResponseJson: [String: Any] = [ResutlListKey: [],
                                       ResuslKey: RequestResultSuccess,
                                       ErrorMessageKey: ""]

///数据库基类
class BaseOperator {
    let dataBaseName = "Mini"
    var mysql: MySQL {
        get {
            return MySql.shareInstance(dataBaseName: dataBaseName)
        }
    }
    var responseJson: [String: Any] = BaseResponseJson
}

///操作用户相关数据表
class UserOperator: BaseOperator {
    let userTableName = "user"
    
    func insertUserInfo(userName: String, password: String) -> String? {
        let values = "('\(userName)','\(password)')"
        let statement = "insert into \(userTableName) (username,password) values \(values)"
        
        LogFile.info("执行SQL: \(statement)")
        if !mysql.query(statement: statement) {
            LogFile.error("\(statement)插入失败")
            self.responseJson[ResuslKey] = RequestResultFailure
            self.responseJson[ErrorMessageKey] = "创建\(userName)失败"
            guard let json = try? responseJson.jsonEncodedString() else {
                return nil
            }
            return json
        }else {
            LogFile.info("插入成功")
            return queryUserInfo(userName: userName)
        }
    }
    
    func deleteUser(userId: String) -> String? {
        let statement = "delete from \(userTableName) where id='\(userId)'"
        
        LogFile.info("执行SQL: \(statement)")
        if !mysql.query(statement: statement) {
            self.responseJson[ResuslKey] = RequestResultFailure
            self.responseJson[ErrorMessageKey] = "删除失败"
            LogFile.error("SQL: \(statement) 删除失败")
        } else {
            LogFile.info("SQL: \(statement) 删除成功")
            self.responseJson[ResuslKey] = RequestResultSuccess
        }
        guard let json = try? responseJson.jsonEncodedString() else {
            return nil
        }
        return json
    }
    
    func updateUserInfo(userId: String, userName: String, password: String) -> String? {
        let statement = "update \(userTableName) set username='\(userName)', password='\(password)', create_time=now() where id='\(userId)'"
        
        LogFile.info("执行SQL: \(statement)")
        
        if !mysql.query(statement: statement) {
            LogFile.error("\(statement) 更新失败")
            self.responseJson[ResuslKey] = RequestResultFailure
            self.responseJson[ErrorMessageKey] = "更新失败"
            guard let json = try? responseJson.jsonEncodedString() else {
                return nil
            }
            return json
        } else {
            LogFile.info("SQL: \(statement) 更新成功")
            return queryUserInfo(userName: userName)
        }
    }
    
    func queryUserInfo(userName: String) -> String? {
        let statement = "select id, username, password, create_time from user where username = '\(userName)'"
        
        LogFile.info("执行SQL: \(statement)")
        
        if !mysql.query(statement: statement) {
//            self.responseJson[ResuslKey] = RequestResultFailure
//            self.responseJson[ErrorMessageKey] = "查询失败"
            LogFile.error("SQL: \(statement) 查询失败")
        
            return nil

        } else {
            LogFile.info("SQL: \(statement) 查询成功")
            
            //在当前会话中保存查询结果
            let results = mysql.storeResults()!
            
            //创建一个字典数组用于存储结果
            var dic = [String: String]()
            
            results.forEachRow(callback: { (row) in
                //保存选项表的Name名称字段，应该是所在行的第一行，所以是row[0]
                guard let userId = row.first! else {
                    return
                }
                dic["userId"] = "\(userId)"
                dic["userName"] = "\(row[1]!)"
                dic["password"] = "\(row[2]!)"
                dic["create_time"] = "\(row[3]!)"
            })
            self.responseJson[ResuslKey] = RequestResultSuccess
            self.responseJson[ResutlListKey] = dic
        }
        guard let json = try? responseJson.jsonEncodedString() else {
            return nil
        }
        return json
    }
}



