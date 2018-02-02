import PerfectHTTP
import PerfectHTTPServer
import Foundation
import PerfectSQLite
import PerfectLib

let dbPath = "./db/database"
do {
    let sqlite = try SQLite(dbPath)
    defer {
        sqlite.close() // This makes sure we close our connection.
    }
    try sqlite.execute(statement: "create table if not exists demo (uid integer primary key not null, name text not null)")
} catch {
    Log.debug(message: "\(error)")
}

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
routes.add(method: .get, uri: "/add") {
    request, response in
    let sqlite = try SQLite(dbPath)
    }
routes.add(method: .get, uri: "/show") {
    request, response in
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "application/json")
    var dictArray:[[String:Any]] = Array()
    let sqlite = try SQLite(dbPath)
    try? sqlite.forEachRow(statement: "select * from demo", handleRow: { (stmt, index) in
            dictArray.append([
                "uid": stmt.columnInt(position: 0),
                "name": stmt.columnText(position: 1)
                ])
        })
    let result = try? [
        "code": 200,
        "data": dictArray,
        "path": request.path
        ].jsonEncodedString()
    response.setBody(string: result!)
    response.completed()
}


do {
    // 启动HTTP服务器
    try HTTPServer.launch(
        .server(name: "www.example.ca", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}

