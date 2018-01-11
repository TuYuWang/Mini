//
//  HandlerUser.swift
//  Perfect-App-TemplatePackageDescription
//
//  Created by 涂育旺 on 2018/1/11.
//

import PerfectHTTP
import PerfectLogger

fileprivate let userKey = "userKey"

extension Handlers {
    
    ///注册用户
    static func register(data: [String: Any]) throws -> RequestHandler {
        return { request, response in
            
            guard let userName = request.param(name: userKey) else {
                let error = "userName为nil"
                
                LogFile.error(error)
                let result = Results(data: nil, code: "200", msg: error)
                
                
                response.setBody(json: result)
                return
            }
            //检验用户名是否合法
            
            //查询用户是否存在
            
        }
    }
}
