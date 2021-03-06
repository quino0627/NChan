//
//  SettingsTableViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 3..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase


class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var loginButton: UILabel!
    @IBAction func loginButtonTouched(_ sender: Any) {
        if loginButton.text == "로그아웃"{
            do {
                try Auth.auth().signOut()
                print("Logout")
                
            } catch  {
                print("Error")
            }
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Auth.auth().addStateDidChangeListener({(user, err) in
//            if user == nil{ //로그인이 되어 있지 않을 경우 로그인 테이블의 label을 '로그인'으로 변경한다.
//                self.loginButton.text = "로그인"
//
//            }else{//로그인이 되어 있을 경우 로그인 테이블의 label을 '로그아웃'으로 변경한다.
//                self.loginButton.text = "로그아웃"
//            }
//        })
        
        if Auth.auth().currentUser != nil {
            self.loginButton.text = "로그아웃"
        }else{
            self.loginButton.text = "로그인"
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = false;
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
