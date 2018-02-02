//
//  Tools.swift
//  PerfectDemoPackageDescription
//
//  Created by yuelixing on 2018/2/2.
//

import Foundation
import PerfectLib

class Tools {
    public static func convertResult(code:Int = 200, data:Any) -> Any {
        return try? [
                "code": code,
                "data": data
            ].jsonEncodedString()
    }
}
