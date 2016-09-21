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
        self.emoticonView.backgroundColor = UIColor.orange
        self.emoticonView.tintColor = UIColor.white
        self.exploreButton.layer.cornerRadius = 20
        self.historyCollectionView.backgroundColor = UIColor.white
    }
    
    
    
    @IBAction func explodeTapped(_ sender: AnyObject) {
//        self.randomizeColor()
//        self.addToHistory()
        
        let searchVC = UIStoryboard(name: SearchEmojiViewController.kStoryboardName, bundle: nil).instantiateViewController(withIdentifier: SearchEmojiViewController.kControllerIdentifier)
        self.present(searchVC, animated: true, completion: nil)
    }
    
    fileprivate func addToHistory() {
        let name = "happy-\(self.history.count)"
        let emoticon = Emoticon(name: name, backgroundColor: self.emoticonView.backgroundColor!, tintColor: self.emoticonView.tintColor)
        history.insert(emoticon, at: 0)
        historyCollectionView.reloadData()
        
        //Save tp Disk
        saveToDisk(emoticon)
    }
    
    fileprivate func randomizeColor() {
        let redValue:CGFloat = CGFloat(arc4random()%255)/255.0
        let blueValue:CGFloat = CGFloat(arc4random()%255)/255.0
        let greenValue:CGFloat = CGFloat(arc4random()%255)/255.0
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.emoticonView.backgroundColor = randomColor
    }
    
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
    
    fileprivate func saveToDisk(_ emoticon:Emoticon) {
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
        let filename = emoticon.name + ".png"
        let fileurl = directoryPath.appendingPathComponent("\(filename)")
        print(fileurl.path)
        do {
            try UIImagePNGRepresentation(image)!.write(to: URL(fileURLWithPath: fileurl.path), options: NSData.WritingOptions.atomic)
        } catch {
            print("Issues writing to file")
        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonHistoryCell.kIdentifier, for: indexPath) as! EmoticonHistoryCell
        cell.setContent(history[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40.0,height: 40.0)
    }
}

