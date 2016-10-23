//
//  ViewExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 13/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//


import UIKit

/**
 Extension to make rounded rect view with provided corner radius
 Storyboard complaint for real time preview
*/
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

/**
    Extension to make rounded view
    Usage: User profile picture view
 */
@IBDesignable
class RoundedView : UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.bounds.size.width/2.0
    }
}

class RoundedImageView : UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.bounds.size.width/2.0
    }
}

class AppNavigationView : UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ApplicationTheme.color()
    }
}

