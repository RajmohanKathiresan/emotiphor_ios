//
//  EmojiCell.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 18/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell {
 
    static let kIdentifier = "EmojiCell"
    static let kPreferredSize = CGSize(width: 40, height: 40)
    
    @IBOutlet weak var emojiView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emojiView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(withEmoji emoji:RMEmoji) {
        emojiView.image = UIImage(named: emoji.unicode)
    }
}
