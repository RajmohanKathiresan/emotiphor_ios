//
//  HomeMenuCell.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 22/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

class HomeMenuCell: UICollectionViewCell {
    
    static let kIdentifier = "HomeMenuCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var rootView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.iconImageView.image = nil
        self.rootView.backgroundColor = UIColor.white
    }
    
    func setContent(_ menu:HomeMenu) {
        self.titleLabel.text = menu.title
        self.iconImageView.image = UIImage(named: menu.imageName)
        self.rootView.backgroundColor = UIColor(netHex: menu.colorCode)
    }
}
