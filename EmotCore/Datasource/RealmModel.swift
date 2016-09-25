//
//  RealmModel.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 17/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation
import RealmSwift

public class RMEmoji : Object {
    
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
    
    public dynamic var id:Int = 0
    public dynamic var uniqueKey:String = ""
    
    public dynamic var category:String = ""
    public dynamic var emoji_order:Int = 0
    public dynamic var name:String = ""
    public dynamic var shortname:String = ""
    public dynamic var unicode:String = ""
    public dynamic var unicode_alternates:String = ""
    
    //Array delimited by '|'
    public dynamic var aliases:String = ""
    public dynamic var aliases_ascii:String = ""
    public dynamic var keywords:String = ""
    
    override public static func indexedProperties() -> [String] {
        return [Field.Name,Field.ShortName,Field.Keywords,Field.Category]
    }
    
    override public static func primaryKey() -> String? {
        return Field.ID
    }
}

public class RMEmojiCategory : Object {
    
    dynamic var id:Int = 0
    dynamic var name:String = ""
}
