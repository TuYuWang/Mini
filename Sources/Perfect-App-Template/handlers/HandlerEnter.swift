//
//  HandlerEnter.swift
//  Perfect-App-TemplatePackageDescription
//
//  Created by 涂育旺 on 2018/1/8.
//

import PerfectHTTP
import StORM
import PerfectLogger

extension Handlers {
    
    static func login(data: [String: Any]) throws -> RequestHandler {
        return { request, response in
            guard let userName = request.param(name: "userName") else {
                return
            }
            guard let password = request.param(name: "password") else {
                return
            }
            let responseData: [String: Any] = ["data": ["userName": userName, "password": password],
                                               "result": "SUCCESS",
                                               "msg": "登录成功"]
            do {
                let json = try responseData.jsonEncodedString()
                response.setBody(string: json)
            } catch  {
                response.setBody(string: "json转换错误")
            }
            
            response.completed()
        }
    }
    
    static func create(data: [String:Any]) throws -> RequestHandler {
        return { request, response in
            guard let userName: String = request.param(name: "userName") else {
                LogFile.error("userName为nil")
                response.completed()
                return
            }
            guard let password: String = request.param(name: "password") else {
                LogFile.error("password为nil")
                response.completed()
                return
            }
            guard let json = UserOperator().insertUserInfo(userName: userName, password: password) else {
                LogFile.error("json为nil")
                response.completed()
                return
            }
            
            LogFile.info(json)
            response.setBody(string: json)
            response.completed()
        }
    }
    
    static func insert(data: [String: Any]) throws -> RequestHandler {
        return { request, response in
            guard let userName = request.param(name: "userName") else {
                LogFile.error("userName为nil")
                response.completed()
                return
            }
            
            guard let password = request.param(name: "password") else {
                LogFile.error("password为nil")
                response.completed()
                return
            }
            
            guard let name = UserOperator().queryUserInfo(userName: userName) else {
                guard let json = UserOperator().insertUserInfo(userName: userName, password: password) else {
                    LogFile.error("json为nil")
                    response.completed()
                    return
                }
                LogFile.info(json)
                response.setBody(string: json)
                response.completed()
                return
            }
            
            LogFile.error("用户名:\(name)已存在")
            
            response.completed()
        }
    }
}

