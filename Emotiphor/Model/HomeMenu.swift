//
//  HomeMenu.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 22/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import Foundation

enum HomeMenuType : UInt8 {
    case createCollage = 0
    case createEmojiWall = 1
    case viewGallery = 2
    case goSocial = 3
    case analytics = 4
}

class HomeMenu {
    
    var title:String!
    var imageName:String!
    var type:HomeMenuType = .createCollage
    var colorCode:Int!
    
    init(title:String, type:HomeMenuType, imageName:String, colorCode:Int) {
        self.title = title
        self.type = type
        self.imageName = imageName
        self.colorCode = colorCode
    }
}

extension HomeMenu {
    
    static func defaultItems() -> [HomeMenu] {
        var menus = [HomeMenu]()
        menus.append(HomeMenu(title: "Emoji Collage", type: .createCollage, imageName: "picture-collage", colorCode: 0x7C1C51))
        menus.append(HomeMenu(title: "Emoji Wall", type: .createEmojiWall, imageName: "template", colorCode: 0x441E1C))
        menus.append(HomeMenu(title: "Gallery", type: .viewGallery, imageName: "gallery", colorCode: 0x424716))
        menus.append(HomeMenu(title: "Social", type: .goSocial, imageName: "share", colorCode: 0x827566))
        menus.append(HomeMenu(title: "Analytics", type: .goSocial, imageName: "robot", colorCode: 0x6572B8))
        return menus
    }
}
