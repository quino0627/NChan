//
//  ProfileViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 9..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UITableViewController {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    var uid : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: DataEventType.value) { (datasnapshot) in
            let user = datasnapshot.value as! NSDictionary
            let url = URL(string: user["profileImageUrl"] as! String)
            self.name1.text = user["name"] as! String
            self.name2.text = user["name"] as! String
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
                DispatchQueue.main.sync {
                    self.userImage.image = UIImage(data: data!)
                    self.userImage.layer.cornerRadius = self.userImage.frame.width/2
                    self.userImage.layer.masksToBounds = true
                }
            }).resume()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
