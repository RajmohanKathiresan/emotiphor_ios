//
//  SearchBarExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 24/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func applyTheme() {
        self.backgroundColor = UIColor.clear
        self.backgroundImage = UIImage()
        self.tintColor = ApplicationTheme.color()
    }
}

class AppSearchBar : UISearchBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyTheme()
    }
}
