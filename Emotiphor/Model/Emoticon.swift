//
//  Emoticon.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 15/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

class Emoticon {
    
    var name:String
    var backgroundColor:UIColor
    var tintColor:UIColor

    init(name:String, backgroundColor:UIColor, tintColor:UIColor) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
}