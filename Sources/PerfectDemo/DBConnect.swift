//
//  DBConnect.swift
//  PerfectDemo
//
//  Created by yuelixing on 2018/2/4.
//

import Foundation
import PerfectSQLite
import PerfectLib

class DBConnect {
    static let dbPath = "../database.sqlite"
    static let connect:SQLite = try! SQLite(dbPath)
//    {
//        get {
//            if self.connect == nil {
//                do {
//                    self.connect = try SQLite(dbPath, readOnly: false, busyTimeoutMillis: 10)
//                } catch {
//                    Log.error(message: "\(error)")
//                }
//            }
//            return self.connect
//        }
//        set {
//            self.connect = newValue
//        }
//    }
//    private static var sqliteConnect:SQLite {
//        set {
//            self.sqliteConnect = newValue
//        }
//        get {
//            return self.sqliteConnect
//        }
//    }
//    public static func connect () -> SQLite {
//        static var sqlConnnect:SQLite? = nil;
//        if sqlConnnect == nil {
//            do {
//                sqlConnnect = try SQLite(dbPath, readOnly: false, busyTimeoutMillis: 10)
//            } catch {
//                Log.error(message: "\(error)")
//            }
//        }
//        return sqlConnnect
//        if self.sqliteConnect == nil {
//            do {
//                self.sqliteConnect = try SQLite(dbPath, readOnly: false, busyTimeoutMillis: 10)
//            } catch {
//                Log.error(message: "\(error)")
//            }
//        }
//        return sqliteConnect
//    }
}
