//
//  Routes.swift
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

import PerfectHTTPServer

func mainRoutes() -> [[String: Any]] {

	var routes: [[String: Any]] = [[String: Any]]()
	// Special healthcheck
	routes.append(["method":"get", "uri":"/healthcheck", "handler":Handlers.healthcheck])

	// Handler for home page
	routes.append(["method":"get", "uri":"/", "handler":Handlers.main])

    // Login
    routes.append(["method":"post", "uri":"/login", "handler":Handlers.login])
    
    // Database - insertUserInfo
    routes.append(["method":"get", "uri":"/insert", "handler":Handlers.insert])
    
    // Database - deleteUser
    routes.append(["method":"delete", "uri":"/delete", "handler":Handlers.create])
    
    // Database - updateUserInfo
    routes.append(["method":"update", "uri":"/update", "handler":Handlers.create])
    
    // Database - queryUserInfo
    routes.append(["method":"update", "uri":"/query", "handler":Handlers.create])
    
    //regiseter
    routes.append(["method": "get", "uri": "/regist", "handler":Handlers.regist])
    
	return routes
}
