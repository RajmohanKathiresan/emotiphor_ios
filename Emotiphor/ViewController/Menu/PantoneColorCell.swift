//
//  PantoneColorCell.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 23/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit
import EmotCore

class PantoneColorCell: UICollectionViewCell {
    
    static let kIdentifier = "PantoneColorCell"
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colorView.layer.borderColor = ApplicationTheme.lightGrayColor().cgColor
        self.colorView.layer.borderWidth = 0.3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.colorView.backgroundColor = UIColor.white
    }
    
    func setContent(withColor color:RMPantoneColor) {
        self.colorView.backgroundColor = UIColor(hexString: color.hex)
    }
}
