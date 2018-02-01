import PerfectHTTP
import PerfectHTTPServer
import Foundation

// 注册您自己的路由和请求／响应句柄
var routes = Routes()
routes.add(method: .get, uri: "/") {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
        .completed()
}
routes.add(method: .get, uri: "/123") {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title></title><body>Hello, world!<br>123!</body></html>")
        .completed()
}
//routes.add(method: .get, uri: "/json") { request, response in
//    response.setHeader(.contentType, value: "application/json")
//    if #available(OSX 10.13, *) {
//        let data = try JSONSerialization.data(withJSONObject: [
//            "code": 200,
//            "data": "jsonString"
//            ], options: JSONSerialization.WritingOptions.sortedKeys)
//        response.appendBody(string: String(data: data, encoding: String.Encoding.utf8))
//    } else {
//        response.setBody(string: "版本太低")
//    }
//    //    response.appendBody(string: "<html><title></title><body>Hello, world!<br>123!</body></html>")
//    //        .completed()
//    response.completed()
//    } as! RequestHandler // as! RequestHandler

//let server = HTTPServer()


do {
    // 启动HTTP服务器
    try HTTPServer.launch(
        .server(name: "www.example.ca", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}

