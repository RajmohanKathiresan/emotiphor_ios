//
//  SearchEmojiViewController.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 18/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit
import RealmSwift

class SearchEmojiViewController: UIViewController {

    static let kStoryboardName = "EmojiSearch"
    static let kControllerIdentifier = "SearchEmojiViewController"
    
    var emojis:Results<RMEmoji>! = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emojiCollectionView.backgroundColor = UIColor.white
        self.emojis = DataServices.shared.getEmojis()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchEmojiViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis != nil ? emojis.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.kIdentifier, for: indexPath) as! EmojiCell
        cell.setContent(withEmoji: emojis[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return EmojiCell.kPreferredSize
    }
}
