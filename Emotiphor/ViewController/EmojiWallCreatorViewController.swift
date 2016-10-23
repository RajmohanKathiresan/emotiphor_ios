//
//  EmojiWallCreatorViewController.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 22/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit
import EmotCore

class EmojiWallCreatorViewController: UIViewController {

    static let kStoryboardName = "EmojiWallCreator"
    static let kControllerIdentifier = "EmojiWallCreatorViewController"
    
    @IBOutlet weak var backBarbutton: UIBarButtonItem!
    @IBOutlet weak var wallView: UIView!
    
    var emoji:RMEmoji!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBarbutton.target = self
        self.backBarbutton.action = #selector(self.backAction(_:))
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.drawPatterns(withEmoji: self.emoji)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backAction(_ sender:AnyObject?) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func drawPatterns(withEmoji emoji:RMEmoji!) {
        self.wallView.layer.borderColor = UIColor.lightGray.cgColor
        self.wallView.layer.borderWidth = 0.5
        self.wallView.layer.masksToBounds = true
        let totalWidth:CGFloat = self.wallView.bounds.size.width
        let totalHeight:CGFloat = self.wallView.frame.size.height
        let itemHeight:CGFloat = 32
        let itemWidth:CGFloat = 32
        let leftPadding:CGFloat = 8
        let topPadding:CGFloat = 8
        let itemGrossWidth = itemWidth + leftPadding
        let itemGrossHeight = itemHeight + topPadding
        print("\(totalHeight):\(totalWidth)")
        var x:CGFloat = leftPadding
        while(x<totalWidth) {
            var y:CGFloat = topPadding
            while (y<totalHeight) {
                let layer = CALayer()
                layer.contentsGravity = kCAGravityResize
                layer.contents = UIImage(named: "1f4d4")?.cgImage
                layer.frame = CGRect(x: x, y: y, width: itemWidth, height: itemHeight)
                layer.opacity = 1
                layer.masksToBounds = true
                let degrees = 0.0
                let radians = CGFloat(degrees * Double.pi / 180)
                layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
                self.wallView.layer.addSublayer(layer)
                y+=itemGrossHeight
            }
            x+=itemGrossWidth
        }
        

    }
}
