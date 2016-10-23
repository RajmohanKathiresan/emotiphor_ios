//
//  Datasource.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 15/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation
import RealmSwift

public class Datasource {
    
}

public class DataServices {
    
    public static let shared = DataServices()
    fileprivate init() {
        var config = Realm.Configuration()
        config.readOnly = false
        config.schemaVersion = 1
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        config.fileURL = documentsPath.appendingPathComponent("emoji.realm")
        Realm.Configuration.defaultConfiguration = config
    }
    
    public func importPantoneColors() {
        let realm = try! Realm()
        let filePath = Bundle(identifier: "com.rajkm.EmotCore")!.path(forResource: "pantone_color", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath!), options: .mappedIfSafe)
            if let colorsArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:AnyObject]] {
                try realm.write({ 
                    for colorDict in colorsArray {
                        let color = RMPantoneColor()
                        color.name = colorDict["pantone"] as? String ?? ""
                        if let hexColor = colorDict["hex"] as? String {
                            color.hex = hexColor
                        }
                        realm.add(color, update: true)
                    }
                })
            }
        }  catch let error {
            print(error.localizedDescription)
            print("Something went wrong while importing JSON data into Realm")
        }
    }
    
    public func getPantoneColors() -> Results<RMPantoneColor> {
        let realm = try! Realm()
        return realm.objects(RMPantoneColor.self).sorted(byProperty: RMPantoneColor.Field.name, ascending: true)
    }

    /// Import emoji meta from Resource/emoji.JSON file
    public func importFromJSON() {
   
        let realm = try! Realm()
        let filePath = Bundle(identifier: "com.rajkm.EmotCore")!.path(forResource: "emoji", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath!), options: .mappedIfSafe)
            if let emojiDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject] {
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
                                newEmoji.aliases = aliases.joined(separator: RMEmoji.Field.Delimiter)
                            }
                            
                            if let keywords = value[RMEmoji.Field.Keywords] as? [String] {
                                newEmoji.keywords = keywords.joined(separator: RMEmoji.Field.Delimiter)
                            }
                            
                            if let aliasesASCII = value[RMEmoji.Field.AliasesASCII] as? [String] {
                                newEmoji.aliases_ascii = aliasesASCII.joined(separator: RMEmoji.Field.Delimiter)
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
    
    public func getEmojis() -> Results<RMEmoji> {
        let realm = try! Realm()
        return realm.objects(RMEmoji.self)
    }
    
    public func searchEmojis(forKeyword keyword:String) -> Results<RMEmoji>! {
        let realm = try! Realm()
        var results:Results<RMEmoji>!
        let processedKeyword = keyword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !processedKeyword.isEmpty {
            let comparison = "Contains[c]"
            let predicate = NSPredicate(format: "\(RMEmoji.Field.Keywords) \(comparison) %@ OR \(RMEmoji.Field.ShortName) \(comparison) %@ OR \(RMEmoji.Field.Category) \(comparison) %@ OR \(RMEmoji.Field.Aliases) \(comparison) %@", processedKeyword, processedKeyword, processedKeyword, processedKeyword)
            results = realm.objects(RMEmoji.self).filter(predicate)
        } else {
            results = realm.objects(RMEmoji.self)
        }
        if results != nil {
            results = results.sorted(byProperty: RMEmoji.Field.EmojiOrder, ascending: true)
        }
        return results
    }
}
