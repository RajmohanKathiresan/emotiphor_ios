//
//  ViewControllerExtensions.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 24/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func GetViewController(instoryboard storyboard:String, withController identifier:String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
