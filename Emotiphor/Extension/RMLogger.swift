//
//  RMLogger.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 24/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation

/// Swift based Logger utility with more details information
class RMLogger {
    
    static var kIdentifier = "Emotiphor"
    
    static func log(message:String, in function:String=#function) {
        print("[\(function)][\(Date())]:"+message)
    }
}
