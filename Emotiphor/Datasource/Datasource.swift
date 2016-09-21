//
//  Datasource.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 15/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation
import RealmSwift

class Datasource {
    
    
}

class DataServices {
    
    static let shared = DataServices()
    private init() {
        var config = Realm.Configuration()
        config.readOnly = false
        config.schemaVersion = 1
        let fileManager = NSFileManager.defaultManager()
        let documentsPath = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        config.fileURL = documentsPath.URLByAppendingPathComponent("emoji.realm")
        Realm.Configuration.defaultConfiguration = config
    }
    
    
    /// Import emoji meta from Resource/emoji.JSON file
    func importFromJSON() {
   
        let realm = try! Realm()
        let filePath = NSBundle.mainBundle().pathForResource("emoji", ofType: "json")
        do {
            let data = try NSData(contentsOfFile: filePath!, options: .DataReadingMappedIfSafe)
            if let emojiDict = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject] {
                try realm.write({
                    var index = 0
                    for emoji in emojiDict {
                        index += 1
                        if let value = emoji.1 as? [String:AnyObject] {
                            let newEmoji = RMEmoji()
                            newEmoji.id = index
                            newEmoji.uniqueKey = emoji.0
                            newEmoji.category = value[RMEmoji.Field.Category] as! String
                            newEmoji.emoji_order = Int(value[RMEmoji.Field.EmojiOrder] as! String)!
                            newEmoji.name = value[RMEmoji.Field.Name] as! String
                            newEmoji.shortname = value[RMEmoji.Field.ShortName] as! String
                            newEmoji.unicode = value[RMEmoji.Field.Unicode] as! String
                            newEmoji.unicode_alternates = value[RMEmoji.Field.UnicodeAlternative] as! String
                            
                            if let aliases = value[RMEmoji.Field.Aliases] as? [String] {
                                newEmoji.aliases = aliases.joinWithSeparator(RMEmoji.Field.Delimiter)
                            }
                            
                            if let keywords = value[RMEmoji.Field.Keywords] as? [String] {
                                newEmoji.keywords = keywords.joinWithSeparator(RMEmoji.Field.Delimiter)
                            }
                            
                            if let aliasesASCII = value[RMEmoji.Field.AliasesASCII] as? [String] {
                                newEmoji.aliases = aliasesASCII.joinWithSeparator(RMEmoji.Field.Delimiter)
                            }
                            
                            realm.add(newEmoji, update: true)
                        }
                    }
                })
            }
        } catch {
            print("Something went wrong while importing JSON data into Realm")
        }
    }
    
    func getEmojis() -> Results<RMEmoji> {
        let realm = try! Realm()
        return realm.objects(RMEmoji)
    }
}
