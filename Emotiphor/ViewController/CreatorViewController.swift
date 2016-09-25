//
//  CreatorViewController.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 13/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit
import EmotCore

class CreatorViewController : UIViewController {
    
    @IBOutlet weak var emoticonView: UIImageView!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    var history:[RMEmoji] = [RMEmoji]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emotiphor"
        self.applyTheme()
        let searchButton = UIBarButtonItem(image: UIImage(named:"search"), style: .plain, target: self, action: #selector(CreatorViewController.searchTapAction(_:)))
        searchButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    fileprivate func applyTheme() {
        self.historyCollectionView.backgroundColor = UIColor.white
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.backgroundColor = ApplicationTheme.color()
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
    
    fileprivate func addToHistory(emoji:RMEmoji) {
        history.insert(emoji, at: 0)
        historyCollectionView.reloadData()
        
        //Save tp Disk
//        saveToDisk(emoji)
    }
    
    fileprivate func randomizeColor() {
        let redValue:CGFloat = CGFloat(arc4random()%255)/255.0
        let blueValue:CGFloat = CGFloat(arc4random()%255)/255.0
        let greenValue:CGFloat = CGFloat(arc4random()%255)/255.0
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.emoticonView.backgroundColor = randomColor
    }
    
    
    /// TODO: Need Refinements
    fileprivate func getImageFromView() -> UIImage {
        let scale = UIScreen.main.nativeScale
        print(scale)
        let actualSize = self.emoticonView.bounds.size
        print("\(actualSize.width):\(actualSize.height)")
        UIGraphicsBeginImageContextWithOptions(actualSize, false, scale)
        self.emoticonView.drawHierarchy(in: self.emoticonView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    fileprivate func saveToDisk(_ emoticon:RMEmoji) {
       let image = getImageFromView()
        let filemanager = FileManager.default
        let path = filemanager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
        print(path)
        let directoryName = "emotiphor"
        let directoryPath = path.appendingPathComponent(directoryName)
        print(directoryPath.path)
        
        do {
            try filemanager.createDirectory(atPath: directoryPath.path, withIntermediateDirectories:false, attributes: nil)
        } catch {
            print("Folder already exists")
        }
        let filename = emoticon.unicode + ".png"
        let fileurl = directoryPath.appendingPathComponent("\(filename)")
        print(fileurl.path)
        do {
            try UIImagePNGRepresentation(image)!.write(to: URL(fileURLWithPath: fileurl.path), options: NSData.WritingOptions.atomic)
        } catch {
            print("Issues writing to file")
        }
    }
    
    func searchTapAction(_:UIBarButtonItem) {
        let searchVC = UIViewController.GetViewController(instoryboard: SearchEmojiViewController.kStoryboardName, withController: SearchEmojiViewController.kControllerIdentifier) as! SearchEmojiViewController
        searchVC.delegate = self
        self.present(searchVC, animated: true, completion: nil)
    }
}

extension CreatorViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return history.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.kIdentifier, for: indexPath) as! EmojiCell
        cell.setContent(withEmoji: history[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40.0,height: 40.0)
    }
}

extension CreatorViewController : SearchEmojiDelegate {
    
    func searchEmojiDidCancel(sender: AnyObject?) {
        //TODO:
    }
    
    func searchEmojiDidSelectEmoji(emoji: RMEmoji, sender: AnyObject?) {
        self.addToHistory(emoji: emoji)
        self.emoticonView.image = UIImage(named: emoji.unicode)
    }
}


