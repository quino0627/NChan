//
//  MyPage.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 12..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase


class MyPage: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewProfile: UITableView!
    var uid = Auth.auth().currentUser?.uid
    var refUser = Database.database().reference().child("users")
    var myModel = UserModel()
    
//    var name = Auth.auth().currentUser?.displayName
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! MyProfileCell
        cell.myName.text = myModel.name
        print(self.myModel.name)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uid = Auth.auth().currentUser?.uid
        
        profileLoad()
        

        tableViewProfile.reloadData()




        // Do any additional setup after loading the view.
    }
    
    func profileLoad() {
    refUser.observe(DataEventType.value, with: { (snapshot) in
            
            for _ in snapshot.children.allObjects as! [DataSnapshot] {
                
                let pchild = snapshot.value as? [String: AnyObject]
                let pUser = UserModel()
                
                pUser.name = pchild?["name"] as? String
                pUser.profileImageUrl = pchild?["profileImageUrl"] as? String
                pUser.uid = pchild?["uid"] as? String
                
                if (pUser.uid == self.uid){
                    
                    self.myModel.name = pUser.name
                    self.myModel.profileImageUrl = pUser.profileImageUrl
                    self.myModel.uid = pUser.uid

                    
                }

            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
