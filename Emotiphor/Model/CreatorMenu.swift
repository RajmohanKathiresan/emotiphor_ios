//
//  CreatorMenu.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 23/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

class CreatorMenu {
    var title:String!
    var order = 0
}

class ColorMenu: CreatorMenu {
    var value:UIColor!
}

class OpacityMenu: CreatorMenu {
    var opacity:CGFloat = 1.0
}
