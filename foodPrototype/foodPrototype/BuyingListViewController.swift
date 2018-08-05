//
//  BuyingListViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 1..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit

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


class BuyingListViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var buyingTable: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var buyingPosts : [ExamplePost] = []
    var boughtPosts : [ExamplePost] = []
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyingCell", for: indexPath)
        var tags : String
        if segmentedControl.selectedSegmentIndex == 0{
            tags = ""
            let item: ExamplePost = buyingPosts[indexPath.row]
            cell.textLabel?.text = item.postTitle
            for tag in item.postTag {
                    tags += tag
            } //태그 연결 및 스트링변환
            cell.detailTextLabel?.text = tags
            cell.imageView?.image = UIImage(named: item.postContent.productPicArray[0])
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
        

        let buyingUser1 = ExampleUser(userName: "김대희", userImage: "프로필")
        let buyingPost1 = ExamplePost(postWriter: buyingUser1,
                                      postTitle: "닭강정 공구팟",
                                      postContent: productInfo(productPicArray: ["pic__thebanchan", "닭강정", "닭강정1", "닭강정2"],
                                                               productType: foodType.banchan,
                                                               productExplanation: "닭강정이 먹고싶습니다.",
                                                               price: "20000"),
                                      postTag: ["#반찬", "#고기"])
        let buyingUser2 = ExampleUser(userName: "송동욱", userImage: "프로필")
        let buyingPost2 = ExamplePost(postWriter: buyingUser2,
                                      postTitle: "오이소박이 공구 모집",
                                      postContent: productInfo(productPicArray: ["pic__oisobak"],
                                                               productType: foodType.banchan,
                                                               productExplanation: "오이소박이가 너무나도 먹고 싶습니다...",
                                                               price: "5000"),
                                      postTag: ["#반찬", "#채소"])
        
        let boughtUser1 = ExampleUser(userName: "정소영", userImage: "프로필")
        let boughtPost1 = ExamplePost(postWriter: boughtUser1,
                                      postTitle: "오거리 수박엔빵~!",
                                      postContent: productInfo(productPicArray: ["pic__watermelon","수박"],
                                                               productType: foodType.banchan,
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
