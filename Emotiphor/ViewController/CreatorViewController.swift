//
//  CreatorViewController.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 13/09/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit

class CreatorViewController : UIViewController {
    
    @IBOutlet weak var emoticonView: UIImageView!
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    var history:[Emoticon] = [Emoticon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emotiphor"
        self.emoticonView.layer.cornerRadius = 25.0
        self.emoticonView.backgroundColor = UIColor.orangeColor()
        self.emoticonView.tintColor = UIColor.whiteColor()
        self.exploreButton.layer.cornerRadius = 20
        self.historyCollectionView.backgroundColor = UIColor.whiteColor()
        
    }
    @IBAction func explodeTapped(sender: AnyObject) {
        self.randomizeColor()
        self.addToHistory()
    }
    
    private func addToHistory() {
        let name = "happy-\(self.history.count)"
        let emoticon = Emoticon(name: name, backgroundColor: self.emoticonView.backgroundColor!, tintColor: self.emoticonView.tintColor)
        history.insert(emoticon, atIndex: 0)
        historyCollectionView.reloadData()
        
        //Save tp Disk
        saveToDisk(emoticon)
    }
    
    private func randomizeColor() {
        let redValue:CGFloat = CGFloat(rand()%255)/255.0
        let blueValue:CGFloat = CGFloat(rand()%255)/255.0
        let greenValue:CGFloat = CGFloat(rand()%255)/255.0
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.emoticonView.backgroundColor = randomColor
    }
    
    private func getImageFromView() -> UIImage {
        let scale = UIScreen.mainScreen().nativeScale
        print(scale)
        let actualSize = self.emoticonView.bounds.size
        print("\(actualSize.width):\(actualSize.height)")
        UIGraphicsBeginImageContextWithOptions(actualSize, false, scale)
        self.emoticonView.drawViewHierarchyInRect(self.emoticonView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private func saveToDisk(emoticon:Emoticon) {
       let image = getImageFromView()
        let filemanager = NSFileManager.defaultManager()
        let path = filemanager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first!
        print(path)
        let directoryName = "emotiphor"
        let directoryPath = path.URLByAppendingPathComponent(directoryName)
        print(directoryPath.path!)
        
        do {
            try filemanager.createDirectoryAtPath(directoryPath.path!, withIntermediateDirectories:false, attributes: nil)
        } catch {
            print("Folder already exists")
        }
        let filename = emoticon.name + ".png"
        let fileurl = directoryPath.URLByAppendingPathComponent("\(filename)")
        print(fileurl.path!)
        do {
            try UIImagePNGRepresentation(image)!.writeToFile(fileurl.path!, options: NSDataWritingOptions.DataWritingAtomic)
        } catch {
            print("Issues writing to file")
        }
    }
}

extension CreatorViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return history.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonHistoryCell.kIdentifier, forIndexPath: indexPath) as! EmoticonHistoryCell
        cell.setContent(history[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 40.0,height: 40.0)
    }
}

