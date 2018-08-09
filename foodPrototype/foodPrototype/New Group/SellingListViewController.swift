//
//  SellingListViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SellingListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var buyingTable: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //    var uid : String?
    var buyingPosts : [ExampleFirePost] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯.
    var boughtPosts : [ExampleFirePost] = []
    let refPost = Database.database().reference().child("posts")
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        if segmentedControl.selectedSegmentIndex == 0{
            returnValue = buyingPosts.count
        }
        else {
            returnValue = boughtPosts.count
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        if segmentedControl.selectedSegmentIndex == 0{
            let item = buyingPosts[indexPath.row]
            cell.listImage.image = nil
            cell.listProduct.text = item.product
            cell.listPrice.text = item.price
            cell.listPlace.text = item.wishLocation
            cell.listTime.text = nil
            let data = try? Data(contentsOf: URL(string: (item.user?.profileImageUrl)!)!)
            cell.listImage.image = UIImage(data: data!)
        }
        else{
            let item = boughtPosts[indexPath.row]
            cell.listImage.image = nil
            cell.listProduct.text = item.product
            cell.listPrice.text = item.price
            cell.listPlace.text = item.wishLocation
            cell.listTime.text = nil
//            let data = try? Data(contentsOf: URL(string: (item.user?.profileImageUrl)!)!)
//            cell.listImage.image = UIImage(data: data!)
            
        }
        
        return cell
    }
    
    @IBAction func refreshButtonTapped(sender: AnyObject){
        buyingTable.reloadData()
    }
    
    @IBAction func segmentedControlActionChanged(sender: AnyObject){
        buyingTable.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        uid = Auth.auth().currentUser?.uid
        
        refPost.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0{
                if self.segmentedControl.selectedSegmentIndex == 0{
                    //clearing list
                    self.buyingPosts.removeAll()
                }
                else{
                    self.boughtPosts.removeAll()
                    
                }
                //iterating through all the values
                for posts in snapshot.children.allObjects as! [DataSnapshot]{
                    //getting values
                    let postObject = posts.value as? [String: AnyObject]
                    let postProduct = postObject?["postProduct"]
                    let postId = postObject?["id"]
                    let postContent = postObject?["postContent"]
                    let postMaxMan = postObject?["postMaxMan"]
                    let postPrice = postObject?["postPrice"]
                    let postWishLocation = postObject?["postWishLocation"]
                    let postUid = postObject?["uid"]
                    var postUser : ExampleFireUser?
                
                    Database.database().reference().child("users").observe(DataEventType.value, with: { (snapshot) in
                        for user in snapshot.children.allObjects as! [DataSnapshot]{
                            let pchild = user.value as? [String:AnyObject]
                            let pUser = ExampleFireUser()
                            if pchild?["uid"] as! String == postUid as! String{
                                pUser.name = pchild?["name"] as! String
                                pUser.profileImageUrl = pchild?["profileImageUrl"] as! String
                                pUser.uid = pchild?["uid"] as! String
                                postUser = pUser
                            }
                        }
                    })
//                    postUid?.observe(DataEventType.value, with: { (snapshot) in
//                        for child in snapshot.children{
//                            let pchild = child as! DataSnapshot
//                            let pUser = ExampleFireUser()
//                            pUser.setValuesForKeys(pchild.value as! [String : Any])
//                            postUser = pUser
//                        }
//                    })
                    
                    //creating post object with model and fetched values
                    let post = ExampleFirePost(id: postId as! String?, product: postProduct as! String?, content: postContent as! String?, maxMan: postMaxMan as! String?, price: postPrice as! String?, wishLocation: postWishLocation as! String?, user: postUser)
                    
                    if self.segmentedControl.selectedSegmentIndex == 0{
                        self.buyingPosts.append(post)
                    }
                    else{
                        self.boughtPosts.append(post)
                    }
                }
                
                //reloading the tableview
                self.buyingTable.reloadData()
            }
        }
        
        
        //        let buyingUser1 = ExampleUser(userName: "김대희", userImage: "프로필")
        //        let buyingPost1 = ExamplePost(postWriter: buyingUser1,
        //                                      postTitle: "닭강정 공구팟",
        //                                      postContent: productInfo(productPicArray: ["pic__thebanchan", "닭강정", "닭강정1", "닭강정2"],
        //                                                               productExplanation: "닭강정이 먹고싶습니다.",
        //                                                               price: "20000"),
        //                                      postTag: ["#반찬", "#고기"])
        //        let buyingUser2 = ExampleUser(userName: "송동욱", userImage: "프로필")
        //        let buyingPost2 = ExamplePost(postWriter: buyingUser2,
        //                                      postTitle: "오이소박이 공구 모집",
        //                                      postContent: productInfo(productPicArray: ["pic__oisobak"],
        //                                                               productExplanation: "오이소박이가 너무나도 먹고 싶습니다...",
        //                                                               price: "5000"),
        //                                      postTag: ["#반찬", "#채소"])
        //
        //        let boughtUser1 = ExampleUser(userName: "정소영", userImage: "프로필")
        //        let boughtPost1 = ExamplePost(postWriter: boughtUser1,
        //                                      postTitle: "오거리 수박엔빵~!",
        //                                      postContent: productInfo(productPicArray: ["pic__watermelon","수박"],
        //                                                               productExplanation: "수박이 먹고 싶은데 양이 너무 많아요 ㅜㅜ...",
        //                                                               price: "10000"),
        //                                      postTag: ["#간식", "#과일"])
        //        buyingPosts.append(buyingPost1)
        //        buyingPosts.append(buyingPost2)
        //        boughtPosts.append(boughtPost1)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segmentedControl.selectedSegmentIndex == 0{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost :ExampleFirePost = buyingPosts[indexPath.row]
                detailVC.post = selectedPost
            }
        }
        else{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost :ExampleFirePost = buyingPosts[indexPath.row]
                detailVC.post = selectedPost
            }
        }
    }
}
