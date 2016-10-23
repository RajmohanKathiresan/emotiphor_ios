//
//  RMPantonColor.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 23/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation
import RealmSwift

public class RMPantoneColor : Object {
    
    struct Field {
        static let name:String = "name"
        static let hex:String = "hex"
    }
    
    public dynamic var name:String = "White"
    public dynamic var hex:String = "#FFFFFF"
    
    override public static func indexedProperties() -> [String] {
        return [Field.name, Field.hex]
    }
    
    override public static func primaryKey() -> String {
        return Field.name
    }
}
