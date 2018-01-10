//
//  Handlers.swift
//  Perfect-App-Template
//
//  Created by Jonathan Guthrie on 2017-02-20.
//	Copyright (C) 2017 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import StORM

class Handlers {

	// Basic "main" handler - simply outputs "Hello, world!"
	static func main(data: [String:Any]) throws -> RequestHandler {
		return {
			request, response in
            response.setBody(string: "<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><title>登录</title></head><body><h1>尊敬的{{title}},请登录</h1><form action='http://127.0.0.1:8181/login' method='POST'>用户名: <input type='text' name='userName'/><br/>密&nbsp;&nbsp;&nbsp;码: <input type='password' name='password'/><br/><input type='submit' value='提交'/></form></body></html>")
			response.completed()
		}
	}

}
