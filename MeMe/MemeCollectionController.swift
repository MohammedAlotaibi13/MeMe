//
//  MemeCollectionController.swift
//  MeMe
//
//  Created by محمد عايض العتيبي on ١٤ شعبان، ١٤٣٨ هـ.
//  Copyright © ١٤٣٨ code schoole. All rights reserved.
//

import Foundation
import UIKit
class MemeCollectionController: UICollectionViewController  {
    
    var memes : [Meme]!
    
    @IBOutlet weak var flowlayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dismension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowlayout.minimumInteritemSpacing = space
        flowlayout.minimumLineSpacing = space
        flowlayout.itemSize = CGSize(width: dismension, height: dismension)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: "rightbutton")
        
    }
    
    func rightbutton(){
    let firstController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
       present(firstController, animated: true, completion: nil)
    
    
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let applactiondelgate = UIApplication.shared.delegate as! AppDelegate
        memes = applactiondelgate.memes
        collectionView?.reloadData()
        tabBarController?.tabBar.isHidden = false
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let CollectionIdentifier = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollectionController", for: indexPath) as! CollectionViewCell
        let MemeCell = memes[(indexPath as NSIndexPath).row]
        
        CollectionIdentifier.imageviewCell.image = MemeCell.memedImage
        return CollectionIdentifier
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DeatilesCell = self.storyboard?.instantiateViewController(withIdentifier: "MemeDeatilesCell") as! MemeDeatilesCell
        DeatilesCell.mems2 = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(DeatilesCell, animated: true)
        

    }

}
