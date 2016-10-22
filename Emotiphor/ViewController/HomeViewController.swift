//
//  HomeViewController.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 22/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let menus = HomeMenu.defaultItems()
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emotiphor"
        self.menuCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuCell.kIdentifier, for: indexPath) as! HomeMenuCell
        cell.setContent(menus[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = (collectionView.frame.width/2.0) - 10
        let height:CGFloat = width
        if(indexPath.row == menus.count-1 && (indexPath.row+1)%2 != 0) {
           width = collectionView.frame.width
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = menus[indexPath.row]
        switch menu.type {
        case .createCollage:
            let creatorController = UIViewController.GetViewController(instoryboard: CreatorViewController.kStoryboardName, withController: CreatorViewController.kControllerIdentifier) as! CreatorViewController
            self.navigationController?.pushViewController(creatorController, animated: true)
            break
        case .createEmojiWall:
            let emojiWallController = UIViewController.GetViewController(instoryboard: EmojiWallCreatorViewController.kStoryboardName, withController: EmojiWallCreatorViewController.kControllerIdentifier) as! EmojiWallCreatorViewController
            self.navigationController?.pushViewController(emojiWallController, animated: true)
            break
        default:
            break
        }
        
    }
}
