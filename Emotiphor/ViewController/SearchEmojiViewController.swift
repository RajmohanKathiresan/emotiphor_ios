//
//  SearchEmojiViewController.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 18/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit
import RealmSwift
import EmotCore

protocol SearchEmojiDelegate : class {
    func searchEmojiDidSelectEmoji(emoji:RMEmoji,sender:AnyObject?)
    func searchEmojiDidCancel(sender:AnyObject?)
}

class SearchEmojiViewController: UIViewController {

    static let kStoryboardName = "EmojiSearch"
    static let kControllerIdentifier = "SearchEmojiViewController"
    
    var emojis:Results<RMEmoji>! = nil
    weak var delegate:SearchEmojiDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emojiCollectionView.backgroundColor = UIColor.white
        self.searchBar.becomeFirstResponder()
        self.searchEmojis(forkeyword: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        self.delegate?.searchEmojiDidCancel(sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Core Logic
    fileprivate func searchEmojis(forkeyword keyword:String) {
        self.emojis = DataServices.shared.searchEmojis(forKeyword: keyword)
        let count = self.emojis != nil ? self.emojis.count : 0
        RMLogger.log(message:"Search Results - \(count)")
        self.emojiCollectionView.reloadData()
        if (count > 0) {
            self.emojiCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        self.delegate?.searchEmojiDidSelectEmoji(emoji: emoji, sender: self)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchEmojiViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchEmojis(forkeyword: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.delegate?.searchEmojiDidCancel(sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchEmojis(forkeyword: searchBar.text!)
    }
}

