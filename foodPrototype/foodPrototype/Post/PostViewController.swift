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

class PostViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colletion_product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        cell.img.image = colletion_images[indexPath.row]
        cell.product.text = colletion_product[indexPath.row]
        
        return cell
    }

    @IBOutlet weak var usercell: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
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
    var post: PostModel?
    var localSource : [ImageSource] = []

    var colletion_images : [UIImage] = []
    var colletion_product : [String] = []
    var user : NSDictionary?
    
    override func viewWillAppear(_ animated: Bool) {
        food_Price.text = post?.postPrice
        food_Title.text = post?.postProduct
        food_Contents.text = post?.postContent
  //        user_Safety_State.text = post?.postWriter.userSafety.state
//        user_Safety_Face.image = UIImage(named: (post?.postWriter.userSafety.face)!)
//        user_Safety_Num.text = String((post?.postWriter.userSafety.value)!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //the part of imageSlideshow
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
        
        for image in (post?.ImageUrl.values)! {
            let data = try? Data(contentsOf: URL(string: image)!)
            localSource.append(ImageSource(image: UIImage(data: data!)!))
        }
        food_Image.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(PostViewController.didTap))
        food_Image.addGestureRecognizer(recognizer)
        
        InviteButton.addTarget(self, action: #selector(touchedButton), for: .touchUpInside)
        
        //the part of all posts of user
        Database.database().reference().child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: post?.uid).observeSingleEvent(of: DataEventType.value) { (datasnapshot) in
            
            for posts in datasnapshot.children.allObjects as! [DataSnapshot]{
                let postObject = posts.value as? [String: AnyObject]
                
                let postImage = (postObject?["ImageUrl"] as? [String: String])?.first?.value
                let data = try? Data(contentsOf: URL(string: postImage!)!)

                self.colletion_images.append(UIImage(data: data!)!)
                self.colletion_product.append(postObject?["postProduct"] as! String)
                
            }
            
            self.collectionView.reloadData()
        }
        Database.database().reference().child("users").child((post?.uid)!).observeSingleEvent(of: DataEventType.value) { (datasnapshot) in
            let user = datasnapshot.value as! NSDictionary
            let url = URL(string: user["profileImageUrl"] as! String)
            self.user_Name1.text = user["name"] as! String
            self.user_Name2.text = user["name"] as! String
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
                DispatchQueue.main.sync {
                    self.user_Image.image = UIImage(data: data!)
                    self.user_Image.layer.cornerRadius = self.user_Image.frame.width/2
                    self.user_Image.layer.masksToBounds = true
                }
            }).resume()
        }

//        class MyPageTableViewController: UITableViewController {
//            @IBOutlet weak var profileImage: UIImageView!
//            @IBOutlet weak var profileName: UILabel!
//            let uid = Auth.auth().currentUser?.uid
//            override func viewDidLoad() {
//                super.viewDidLoad()
//                print(self.uid)
//                print("유아이디")
//                Database.database().reference().child("users").child(uid!).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
//                    let value = datasnapshot.value as! NSDictionary
//                    self.profileName.text = value["name"] as! String
//                    let ssss = value["profileImageUrl"] as! String
//                    print(ssss)
//                    print("ㄴㄴㄴㄴ")
//                    //let url = URL(string: value.allValues[0] as! String)
//                    let url = URL(string: ssss as! String)
//                    URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
//                        DispatchQueue.main.sync {
//                            self.profileImage.image = UIImage(data:data!)
//                            self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
//                            self.profileImage.layer.masksToBounds = true
//                        }
//                    }).resume()
//
//                })        // Uncomment the following line to preserve selection between presentations
//                // self.clearsSelectionOnViewWillAppear = false
//
//                // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//                // self.navigationItem.rightBarButtonItem = self.editButtonItem
//            }
        
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ProfileViewController{
            let uid = self.post?.uid
            detailVC.uid = uid
        }
    }


}
