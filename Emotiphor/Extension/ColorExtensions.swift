//
//  ColorExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 15/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
