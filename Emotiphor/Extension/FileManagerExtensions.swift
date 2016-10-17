//
//  FileManagerExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 18/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation

/**
 Extension to get documents directory path
*/
extension FileManager {
    
    static func getDocumentsDirectoryPath() -> URL {
        let filemanager = FileManager.default
        return filemanager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
