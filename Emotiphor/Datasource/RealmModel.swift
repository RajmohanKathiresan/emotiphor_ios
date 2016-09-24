//
//  RealmModel.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 17/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation
import RealmSwift

class RMEmoji : Object {
    
    struct Field {
        static let ID = "id"
        static let UniqueKey = "uniqueKey"
        static let Category = "category"
        static let EmojiOrder = "emoji_order"
        static let Name = "name"
        static let ShortName = "shortname"
        static let Unicode = "unicode"
        static let UnicodeAlternative = "unicode_alternates"
        static let Aliases = "aliases"
        static let AliasesASCII = "aliases_ascii"
        static let Keywords = "keywords"
        static let Delimiter = "|"
    }
    
    dynamic var id:Int = 0
    dynamic var uniqueKey:String = ""

    dynamic var category:String = ""
    dynamic var emoji_order:Int = 0
    dynamic var name:String = ""
    dynamic var shortname:String = ""
    dynamic var unicode:String = ""
    dynamic var unicode_alternates:String = ""
    
    //Array delimited by '|'
    dynamic var aliases:String = ""
    dynamic var aliases_ascii:String = ""
    dynamic var keywords:String = ""

    override static func indexedProperties() -> [String] {
        return [Field.Name,Field.ShortName,Field.Keywords,Field.Category]
    }
    
    override static func primaryKey() -> String? {
        return Field.ID
    }
}

class RMEmojiCategory : Object {
    
    dynamic var id:Int = 0
    dynamic var name:String = ""
}
