//
//  PantoneColorPickerController.swift
//  Emotiphor
//
//  Created by Rajmohan Kathiresan on 23/10/16.
//  Copyright © 2016 Rajmohan Kathiresan. All rights reserved.
//

import UIKit
import RealmSwift
import EmotCore

class PantoneColorPickerController: UIViewController {

    static let kStoryboardName = "CreatorMenu"
    static let kControllerIdentifier = "PantoneColorPickerController"
    
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    var pantoneColors:Results<RMPantoneColor>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pantoneColors = DataServices.shared.getPantoneColors()
        self.colorsCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PantoneColorPickerController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pantoneColors != nil ? pantoneColors.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 24.0, height: 24.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PantoneColorCell.kIdentifier, for: indexPath) as! PantoneColorCell
        cell.setContent(withColor: pantoneColors[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedColor = pantoneColors[indexPath.row]
        print(selectedColor.name)
    }
}
