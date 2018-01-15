//
//  MemeDeatilesCell.swift
//  MeMe
//
//  Created by محمد عايض العتيبي on ١٦ شعبان، ١٤٣٨ هـ.
//  Copyright © ١٤٣٨ code schoole. All rights reserved.
//

import Foundation
import UIKit
class MemeDeatilesCell: UIViewController {
    @IBOutlet weak var imageviewCell: UIImageView!
    
    var mems2: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageviewCell.image = mems2.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }

    
    
}
