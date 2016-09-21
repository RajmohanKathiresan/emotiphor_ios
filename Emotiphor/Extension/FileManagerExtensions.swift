//
//  FileManagerExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 18/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation

extension NSFileManager {
    
    static func getDocumentsDirectoryPath() -> NSURL {
        let filemanager = NSFileManager.defaultManager()
        return filemanager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    }
}