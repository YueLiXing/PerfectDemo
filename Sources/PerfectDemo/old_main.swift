////
////  main.swift
////  PerfectTemplate
////
////  Created by Kyle Jessup on 2015-11-05.
////    Copyright (C) 2015 PerfectlySoft, Inc.
////
////===----------------------------------------------------------------------===//
////
//// This source file is part of the Perfect.org open source project
////
//// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
//// Licensed under Apache License v2.0
////
//// See http://perfect.org/licensing.html for license information
////
////===----------------------------------------------------------------------===//
////
//import PerfectLib
//import PerfectHTTP
//import PerfectHTTPServer
//import Foundation
//
//// An example request handler.
//// This 'handler' function can be referenced directly in the configuration below.
//func loginHandler(request: HTTPRequest, response: HTTPResponse) {
//    // Respond with a simple message.
//
//    Log.debug(message: "header:\(request.headers) param:\(request.params()) path:\(request.path)")
//    //    response.setHeader(.contentType, value: "text/html")
//    //    设置为 json
//    response.setHeader(.contentType, value: "application/json")
//
//    do {
//        try response.setBody(json: [
//            "code": 200,
//            "data": nil,
//            "path": request.path
//            ]);
//    } catch {
//        Log.error(message: "\(error)")
//    }
//
//    let uid = request.param(name: "uid")
//    if uid != nil {
//        response.addCookie(HTTPCookie(name: "uid", value: uid!))
//    }
//    response.completed()
//}
//func showHandler(request: HTTPRequest, response: HTTPResponse) {
//    var temp:String? = nil
//    for tempDic in request.cookies {
//        if tempDic.0 == "uid" {
//            temp = tempDic.1
//            break
//        }
//    }
//    response.setHeader(.contentType, value: "application/json")
//    do {
//        try response.setBody(json: ["code":200,"data":["uid":temp],"path":request.path])
//    } catch {
//        Log.error(message: "\(error)")
//    }
//    response.completed()
//}
//
//func logoutHandler(request: HTTPRequest, response: HTTPResponse) {
//    response.setHeader(.contentType, value: "application/json")
//    do {
//        try response.setBody(json: ["code":200,"data":nil,"path":request.path])
//    } catch {
//        Log.error(message: "\(error)")
//    }
//    // 删除 cookie
//    response.setHeader(.setCookie, value: "")
//    response.completed()
//}
//
//
//
//// Configuration data for an example server.
//// This example configuration shows how to launch a server
//// using a configuration dictionary.
//
//let confData = [
//    "servers": [
//        // Configuration data for one server which:
//        //    * Serves the hello world message at <host>:<port>/
//        //    * Serves static files out of the "./webroot"
//        //        directory (which must be located in the current working directory).
//        //    * Performs content compression on outgoing data when appropriate.
//        [
//            "name":"localhost",
//            "port":8181,
//            "routes":[
//                // .../login?uid=123
//                ["method":"get", "uri":"/login", "handler":loginHandler],
//                // .../show
//                ["method":"get", "uri":"/show", "handler":showHandler],
//                // .../logout
//                ["method":"get", "uri":"/logout", "handler":logoutHandler],
//                ["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
//                 "documentRoot":"./webroot",
//                 "allowResponseFilters":true]
//            ],
//            "filters":[
//                [
//                    "type":"response",
//                    "priority":"high",
//                    "name":PerfectHTTPServer.HTTPFilter.contentCompression,
//                    ]
//            ]
//        ]
//    ]
//]
//
////Log.even = true
//do {
//    // Launch the servers based on the configuration data.
//    try HTTPServer.launch(configurationData: confData)
//} catch {
//    fatalError("\(error)") // fatal error launching one of the servers
//}

