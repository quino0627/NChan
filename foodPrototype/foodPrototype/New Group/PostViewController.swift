//
//  PostViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 1..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import ImageSlideshow
import Firebase

class PostViewController: UITableViewController {

    
    @IBOutlet weak var food_Image: ImageSlideshow!
    @IBOutlet weak var food_Price: UILabel!
    @IBOutlet weak var food_Title: UILabel!
    @IBOutlet weak var food_Contents: UILabel!
    @IBOutlet weak var user_Image: UIImageView!
    @IBOutlet weak var user_Name1: UILabel!
    @IBOutlet weak var user_Name2: UILabel!
    @IBOutlet weak var InviteButton: UIButton!
    
    //    @IBOutlet weak var user_Safety_Face: UIImageView!
//    @IBOutlet weak var user_Safety_State: UILabel!
//    @IBOutlet weak var user_Safety_Num: UILabel!
    var post: ExampleFirePost?
    
    
    var localSource : [ImageSource] = []

    override func viewWillAppear(_ animated: Bool) {
        food_Price.text = post?.price
        food_Title.text = post?.product
        food_Contents.text = post?.content
//        user_Image.image = UIImage(named: (post?.postWriter.userImage)!)
//        user_Name1.text = post?.postWriter.userName
//        user_Name2.text = post?.postWriter.userName
//        user_Safety_State.text = post?.postWriter.userSafety.state
//        user_Safety_Face.image = UIImage(named: (post?.postWriter.userSafety.face)!)
//        user_Safety_Num.text = String((post?.postWriter.userSafety.value)!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        for image in (post?.postContent.productPicArray)! {
//            localSource.append(ImageSource(imageString: image)!)
//        }
        
        food_Image.slideshowInterval = 5.0
        food_Image.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        food_Image.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        food_Image.pageIndicator = pageControl

        food_Image.activityIndicator = DefaultActivityIndicator()
        food_Image.currentPageChanged = { page in
            print("current page:", page)
        }
        
        food_Image.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(PostViewController.didTap))
        food_Image.addGestureRecognizer(recognizer)
        
        InviteButton.addTarget(self, action: #selector(touchedButton), for: .touchUpInside)
    }

    @objc func didTap() {
        let fullScreenController = food_Image.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func touchedButton(){
        print("포스트 아이디 프린트")
        print(post?.id as Any)
        var myUid = Auth.auth().currentUser?.uid
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "postId").queryEqual(toValue: post?.id).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            let value = datasnapshot.value as? NSDictionary
            //let userList = value?["users"]
            let chatroomKey = value?.allKeys[0] as! String
            //let originChatMember = value?.value(forKey: chatroomKey)
            let inputValue:Dictionary<String,Any> = [myUid!:true]
            Database.database().reference().child("chatrooms").child(chatroomKey).child("users").observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
                var originChatMember = datasnapshot.value as? NSMutableDictionary
                originChatMember![myUid] = true
                print("챗룸 데이터스냅샷")
                print(originChatMember)
                print(type(of: originChatMember))
                Database.database().reference().child("chatrooms").child(chatroomKey).child("users").setValue(originChatMember)
            })
            //
            print("start")
            //print(userList)
            //print(originChatMember)
            //print(value?.allKeys[0] as! String)
//            print(type(of: datasnapshot))
//            print(type(of: datasnapshot.value))
            print("datasnapshot")
        })
        
        //users[myUid!] = true
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
