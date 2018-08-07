//
//  BuyingListViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 1..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


struct ExampleUser{
    var userName: String
    var userImage: String
}

struct ExamplePost {
//    var postDate: Time
    var postWriter: ExampleUser // 수정
//    var postType : postClassify
    var postTitle:String
    var postContent: productInfo
//    var postCommentArray = Array<comment>()
    var postTag = Array<String>()
}

struct ExampleFirePost {
    var id: String?
    var name: String?
    var postTitle: String?
    var content : String?
    var price : String?
}

class BuyingListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var buyingTable: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var uid : String?
    var buyingPosts : [ExamplePost] = []
    var boughtPosts : [ExamplePost] = []
    var firePosts : [ExampleFirePost] = []
    let refPost = Database.database().reference().child("posts")
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        if segmentedControl.selectedSegmentIndex == 0{
            returnValue = firePosts.count
        }
        else {
            returnValue = boughtPosts.count
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyingCell", for: indexPath)
        var tags : String
        if segmentedControl.selectedSegmentIndex == 0{
            print(firePosts)
            let item = firePosts[indexPath.row]
            cell.textLabel?.text = item.postTitle
            
            cell.detailTextLabel?.text = item.price
        }
        else{
            tags = ""
            let item: ExamplePost = boughtPosts[indexPath.row]
            for tag in item.postTag {
                tags += tag
            } //태그 연결 및 스트링변환
            cell.textLabel?.text = item.postTitle
            cell.detailTextLabel?.text = tags
            cell.imageView?.image = UIImage(named: item.postContent.productPicArray[0])
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
        
        uid = Auth.auth().currentUser?.uid
        
        refPost.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0{
                
                //clearing list
                self.firePosts.removeAll()
                
                //iterating through all the values
                for posts in snapshot.children.allObjects as! [DataSnapshot]{
                    //getting values
                    let postObject = posts.value as? [String: AnyObject]
                    let postName = postObject?["postProduct"]
                    let postId = postObject?["id"]
                    let postContent = postObject?["postContent"]
                    let postPrice = postObject?["postPrice"]
                    let postTitle = postObject?["postMaxMan"]
                    
                    //creating post object with model and fetched values
                    let post = ExampleFirePost(id: postId as! String?, name: postName as! String?, postTitle: postTitle as! String?, content: postContent as! String?, price: postPrice as! String?)
                    
                    
                    //appending it to list
                    self.firePosts.append(post)
                    
                }
                
                //reloading the tableview
                self.buyingTable.reloadData()
            }
        }


        let buyingUser1 = ExampleUser(userName: "김대희", userImage: "프로필")
        let buyingPost1 = ExamplePost(postWriter: buyingUser1,
                                      postTitle: "닭강정 공구팟",
                                      postContent: productInfo(productPicArray: ["pic__thebanchan", "닭강정", "닭강정1", "닭강정2"],
                                                               productExplanation: "닭강정이 먹고싶습니다.",
                                                               price: "20000"),
                                      postTag: ["#반찬", "#고기"])
        let buyingUser2 = ExampleUser(userName: "송동욱", userImage: "프로필")
        let buyingPost2 = ExamplePost(postWriter: buyingUser2,
                                      postTitle: "오이소박이 공구 모집",
                                      postContent: productInfo(productPicArray: ["pic__oisobak"],
                                                               productExplanation: "오이소박이가 너무나도 먹고 싶습니다...",
                                                               price: "5000"),
                                      postTag: ["#반찬", "#채소"])
        
        let boughtUser1 = ExampleUser(userName: "정소영", userImage: "프로필")
        let boughtPost1 = ExamplePost(postWriter: boughtUser1,
                                      postTitle: "오거리 수박엔빵~!",
                                      postContent: productInfo(productPicArray: ["pic__watermelon","수박"],
                                                               productExplanation: "수박이 먹고 싶은데 양이 너무 많아요 ㅜㅜ...",
                                                               price: "10000"),
                                      postTag: ["#간식", "#과일"])
        buyingPosts.append(buyingPost1)
        buyingPosts.append(buyingPost2)
        boughtPosts.append(boughtPost1)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let indexPath = tableView.indexPathForSelectedRow,
//            let detailVC = segue.destination as?
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segmentedControl.selectedSegmentIndex == 0{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost: ExamplePost = buyingPosts[indexPath.row]
                detailVC.post = selectedPost
            }
        }
        else{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost: ExamplePost = boughtPosts[indexPath.row]
                detailVC.post = selectedPost
            }
        }
    }
}
