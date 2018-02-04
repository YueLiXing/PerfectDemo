import PerfectHTTP
import PerfectHTTPServer
import Foundation
import PerfectSQLite
import PerfectLib

var routes = Routes()
routes.add(method: .get, uri: "/") {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!<br>Haha,Kid!</body></html>")
        .completed()
} 

routes.add(method: .get, uri: "/add") { (request, response) in
    let sqlite = DBConnect.connect
    
    let uid = request.param(name: "uid")
    let name = request.param(name: "name")
    var result = ""
    if uid != nil && name != nil {
        do {
            try sqlite.execute(statement: "insert into demo (uid,name) values(:1,:2)", doBindings: { (stmt) in
                try? stmt.bind(position: 1, uid!)
                try? stmt.bind(position: 2, name!)
            })
            result = "保存成功"
            response.setBody(string: Tools.convertResult(data: result))
        } catch {
            response.setBody(string: Tools.convertResult(data: "\(error)"))
            Log.error(message: "\(error)")
        }
    } else {
        result = "参数错误"
        response.setBody(string: Tools.convertResult(code: 300, data: result))
    }
    response.completed()
}
routes.add(method: .get, uri: "/show") { (request, response) in
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "application/json")
    var dictArray:[[String:Any]] = Array()
    let sqlite = DBConnect.connect
    let uid = request.param(name: "uid")
    if uid == nil {
        try? sqlite.forEachRow(statement: "select * from demo", handleRow: { (stmt, index) in
//            Log.debug(message: "\(stmt)");
            dictArray.append([
                "uid": stmt.columnInt(position: 1),
                "name": stmt.columnText(position: 2)
                ])
        })
        Log.debug(message: dictArray.description)
        response.setBody(string:Tools.convertResult(data: dictArray))
    } else {
        try? sqlite.forEachRow(statement: "select * from demo where uid = "+uid!, handleRow: { (stmt, index) in
//            Log.debug(message: "\(stmt)");
            dictArray.append([
                "uid": stmt.columnInt(position: 1),
                "name": stmt.columnText(position: 2)
                ])
        })
        Log.debug(message: dictArray.description)
        if dictArray.count > 0 {
            response.setBody(string:Tools.convertResult(data: dictArray))
        } else {
            response.setBody(string:Tools.convertResult(data: "没有对应的数据"))
        }
    }
    response.completed()
}


do {
    // 启动HTTP服务器
    try HTTPServer.launch(
        .server(name: "www.example.ca", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}
/*
 http://0.0.0.0:8181/show
 http://0.0.0.0:8181/add?uid=1&name=%E7%BB%A7%E5%88%9A
 http://0.0.0.0:8181/add?uid=2&name=%E5%B0%8F%E7%BA%A2
 http://0.0.0.0:8181/show
 http://0.0.0.0:8181/add?uid=3&name=lala
 http://0.0.0.0:8181/show?uid=3
 */
