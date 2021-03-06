//
//  EmoticonHistoryCell.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 15/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

class EmoticonHistoryCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: RoundedImageView!
    static let kIdentifier = "EmoticonHistoryCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.tintColor = UIColor.white
        self.iconImageView.backgroundColor = UIColor.white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(_ emoticon:Emoticon) {
        self.iconImageView.tintColor = emoticon.tintColor
        self.iconImageView.backgroundColor = emoticon.backgroundColor
    }
}
