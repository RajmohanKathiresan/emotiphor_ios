//
//  ViewControllerExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 24/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

/**
 UIViewController extension
 */
extension UIViewController {
    
    /// Get viewcontroller instance specifying the storyboard and controller identifier
    static func GetViewController(instoryboard storyboard:String, withController identifier:String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
