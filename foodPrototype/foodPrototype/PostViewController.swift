//
//  PostViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 1..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit

class PostViewController: UITableViewController {

    
//    class SongDetailViewController: UIViewController {
//
//        @IBOutlet weak var titleLabel: UILabel!
//        @IBOutlet weak var artistLabel: UILabel!
//        var song: Song?
//
//        override func viewWillAppear(_ animated: Bool) {
//            titleLabel.text = song?.title
//            artistLabel.text = song?.artist
//        }
//
//    }
    
    @IBOutlet weak var food_Image: UIImageView!
    @IBOutlet weak var food_Price: UILabel!
    @IBOutlet weak var food_Title: UILabel!
    @IBOutlet weak var food_Contents: UILabel!
    @IBOutlet weak var user_Image: UIImageView!
    @IBOutlet weak var user_Name1: UILabel!
    @IBOutlet weak var user_Name2: UILabel!
    @IBOutlet weak var user_Safety_Face: UIImageView!
    @IBOutlet weak var user_Safety_State: UILabel!
    @IBOutlet weak var user_Safety_Num: UILabel!
    var post: ExamplePost?
    
    
    override func viewWillAppear(_ animated: Bool) {
        //outlet
        if (post?.postContent.productPicArray.count)! > 0{
            food_Image.image = UIImage(named: (post?.postContent.productPicArray[0])!)
        }
        food_Price.text = post?.postContent.price
        food_Title.text = post?.postTitle
        food_Contents.text = post?.postContent.productExplanation
        user_Name1.text = post?.postWriter.userName
        user_Name2.text = post?.postWriter.userName
        user_Safety_State.text = post?.postWriter.userSafety.state
        //user_Safety_Num.text = post?.postWriter.userSafety.value , value가 int라 애매
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


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
