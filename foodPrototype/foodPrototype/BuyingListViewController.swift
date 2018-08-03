//
//  BuyingListViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 1..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit

struct ExampleList {
    var imageName: String
    var title: String
    var mainUser: String
    var tag: String
}

struct ExampleUser{
    var userName: String
    var userImage: String
//    var userSafety: UserSafety
}

//struct UserSafety {
//    var value : Int
//    var face: String {
//        get{
//            if value > 100 {
//                return "my_goodgood"
//            }
//            else {
//                return "my_good"
//            }
//        }
//    }
//    var state : String {
//        get{
//            if value > 100 {
//                return "매우 좋음"
//            }
//            else {
//                return "좋음"
//            }
//        }
//    }
//}

struct ExamplePost {
//    var postDate: Time
    var postWriter: ExampleUser // 수정
//    var postType : postClassify
    var postTitle:String
    var postContent: productInfo
//    var postCommentArray = Array<comment>()
    var postTag = Array<String>()
}

//struct productInfo{
//    var productPicArray = Array<imageFile>()
//    var productType: foodType
//    var productExplanation: String
//    var price : String
//}
//
//struct post {
//    var postDate: Time
//    var postWriter: user
//    var postType : postClassify
//    var postTitle:String
//    var postContent:productInfo
//    var postLike: Int
//    var postCommentArray = Array<comment>()
//    var postTag = Array<String>()
//}

class BuyingListViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var buyingTable: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var posts : [ExamplePost] = []
    
    var buyingList : [ExampleList] =  [
        ExampleList(imageName: "pic__watermelon", title: "오거리 수박엔빵~!", mainUser: "방장: 이현우", tag: "수박")
    ] //구매중
    
    var boughtList : [ExampleList] = [
        ExampleList(imageName: "pic__thebanchan" , title: "더반찬 공구팟 모집", mainUser: "방장: 변지현", tag: "#깍두기 #닭강정")
    ] //구매완료
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            returnValue = buyingList.count
        case 1:
            returnValue = boughtList.count
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyingCell", for: indexPath)
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            let item: ExampleList = buyingList[indexPath.row]
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.tag
            cell.imageView?.image = UIImage(named: item.imageName)
        case 1:
            let item: ExampleList = boughtList[indexPath.row]
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.tag
            cell.imageView?.image = UIImage(named: item.imageName)
        default:
            break
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
        
        let sampleUser = ExampleUser(userName: "김대희", userImage: "프로필")
        let samplePost = ExamplePost(postWriter: sampleUser,
            postTitle: "닭강정 공구팟",
            postContent: productInfo(productPicArray: ["닭강정", "닭강정1", "닭강정2"],
            productType: foodType.banchan,
            productExplanation: "닭강정이 먹고싶습니다.",
            price: "20000"),
            postTag: ["반찬", "고기"])
        
        posts.append(samplePost)
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
        if let indexPath = buyingTable.indexPathForSelectedRow,
            let detailVC = segue.destination as? PostViewController {
            let selectedPost: ExamplePost = posts[indexPath.row]
            detailVC.post = selectedPost
        }
    }

}
