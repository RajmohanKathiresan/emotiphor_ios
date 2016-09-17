//
//  ViewExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 13/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedRectView : UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

class RoundedView : UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.bounds.size.width
    }
}

class RoundedImageView : UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.bounds.size.width/2.0
    }
}