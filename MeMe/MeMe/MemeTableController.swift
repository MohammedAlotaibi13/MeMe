//
//  MemeTableController.swift
//  MeMe
//
//  Created by محمد عايض العتيبي on ١٤ شعبان، ١٤٣٨ هـ.
//  Copyright © ١٤٣٨ code schoole. All rights reserved.
//

import Foundation
import UIKit
class MemeTableController: UITableViewController {
    
    var memes:[Meme]!
    
    let Appdelgeate = (UIApplication.shared.delegate as! AppDelegate)

    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: "rightbutton")
    }
    
    
    func rightbutton(){
    
  
        let firstViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        present(firstViewController, animated: true, completion: nil)
        tabBarController?.tabBar.isHidden = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        memes = Appdelgeate.memes
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let MemeCell = self.memes[(indexPath as NSIndexPath).row]
        cell.labeltable.text = "\(MemeCell.topText)....\(MemeCell.bottomText)"
        cell.imagetable.image = MemeCell.memedImage

        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DeatilesCell = self.storyboard?.instantiateViewController(withIdentifier: "MemeDeatilesCell") as! MemeDeatilesCell
        DeatilesCell.mems2 = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(DeatilesCell, animated: true)
        
    }
       
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
        Appdelgeate.memes.remove(at: indexPath.row)
        memes.remove(at: indexPath.row)
        tableView.reloadData()
        
        }
    }
}
