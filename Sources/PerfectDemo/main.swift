import PerfectHTTP
import PerfectHTTPServer
import Foundation

var count = 0


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
routes.add(method: HTTPMethod.get, uri: "/json") { (request, response) in
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "application/json")
    let result = try? [
        "code": 200,
        "data": [
            "uid": 123,
            "name": "继刚",
            "count": count
        ],
        "path": request.path
        ].jsonEncodedString()
    response.setBody(string: result!)
    count += 1
    response.completed()
}

do {
    // 启动HTTP服务器
    try HTTPServer.launch(
        .server(name: "www.example.ca", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}

