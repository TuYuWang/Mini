//
//  HandlerUser.swift
//  Perfect-App-TemplatePackageDescription
//
//  Created by 涂育旺 on 2018/1/11.
//

import PerfectHTTP
import PerfectLogger

fileprivate let userKey = "username"
fileprivate let passwordKey = "password"

extension Handlers {
    
    ///注册用户
    static func regist(data: [String: Any]) throws -> RequestHandler {
        return { request, response in
            
            guard let userName = request.param(name: userKey) else {
                let error = "userName为nil"
                
                LogFile.error(error)
                let result = Results(data: nil, code: 200, msg: error)
        
                do {
                    let json = try result.jsonEncodedString()
                    response.setBody(string: json)
                } catch  {
                    response.setBody(string: "json转换错误")
                }
                
                response.completed()
                return
            }
            
            //检验用户名是否合法
            
            //检查密码
            guard let password = request.param(name: passwordKey) else {
                let error = "password为nil"
                
                LogFile.error(error)
                let result = Results(data: nil, code: 200, msg: error)
                
                do {
                    let json = try result.jsonEncodedString()
                    response.setBody(string: json)
                } catch  {
                    response.setBody(string: "json转换错误")
                }
                
                response.completed()
                return
            }
            
            //查询用户是否存在
            let name = UserOperator().queryUserInfo(userName: userName)
            if name != nil {
                let msg = "用户名:\(userName)已存在"
                let result = Results(data: nil, code: 200, msg: msg)
                
                do {
                    let json = try result.jsonEncodedString()
                    response.setBody(string: json)
                } catch {
                    response.setBody(string: "json转换错误")
                }
                
                LogFile.error("msg")
                response.completed()
            } else {
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
    }
}
