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
import ImageSlideshow

class SellingListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var buyingTable: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //    var uid : String?
    var sellingPosts : [ExampleFirePost] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯, 진행중/ 완료일때에 따른 변수 넣기
    var soldPosts : [ExampleFirePost] = []
    let refPost = Database.database().reference().child("posts")
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        if segmentedControl.selectedSegmentIndex == 0{
            returnValue = sellingPosts.count
        }
        else {
            returnValue = soldPosts.count
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        if segmentedControl.selectedSegmentIndex == 0{
            let item = sellingPosts[indexPath.row]
            cell.listProduct.text = item.product
            cell.listPrice.text = item.price
            cell.listPlace.text = item.wishLocation
            cell.listTime.text = nil
            let data = try? Data(contentsOf: URL(string: (item.user!.profileImageUrl!))!)
            cell.listImage.image = UIImage(data: data!)
        }
        else{
            let item = soldPosts[indexPath.row]
            cell.listProduct.text = item.product
            cell.listPrice.text = item.price
            cell.listPlace.text = item.wishLocation
            cell.listTime.text = nil
            let data = try? Data(contentsOf: URL(string: (item.user?.profileImageUrl)!)!)
            cell.listImage.image = UIImage(data: data!)
            
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

        refPost.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0{
                if self.segmentedControl.selectedSegmentIndex == 0{
                    //clearing list
                    self.sellingPosts.removeAll()
                }
                else{
                    self.soldPosts.removeAll()
                    
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
                    
                    let postImagesUrl = postObject?["ImageUrl"] as? [String: String]
                    var postImages : [ImageSource?] = []
                    for images in (postImagesUrl?.values)! {
                        let dimage = try? Data(contentsOf: URL(string: (images))!)
                        postImages.append(ImageSource(image: UIImage(data: dimage!)!))
                    }
                    
                    Database.database().reference().child("users").child(postUid as! String).observe(DataEventType.value, with: { (snapshot) in
                        let pchild = snapshot.value as? [String: AnyObject]
                        let pUser = ExampleFireUser()
                        
                        pUser.name = pchild?["name"] as? String
                        pUser.profileImageUrl = pchild?["profileImageUrl"] as? String
                        pUser.uid = pchild?["uid"] as? String
                        let post = ExampleFirePost(images: postImages as? [ImageSource], id: postId as! String?, product: postProduct as! String?, content: postContent as! String?, maxMan: postMaxMan as! String?, price: postPrice as! String?, wishLocation: postWishLocation as! String?, user: pUser)
                        
                        if self.segmentedControl.selectedSegmentIndex == 0{
                        self.sellingPosts.append(post)
                        }
                        else{
                            self.soldPosts.append(post)
                        }
                        self.buyingTable.reloadData()
                    })
                    

                }

            }
        }
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segmentedControl.selectedSegmentIndex == 0{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost :ExampleFirePost = sellingPosts[indexPath.row]
                detailVC.post = selectedPost
            }
        }
        else{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost :ExampleFirePost = soldPosts[indexPath.row]
                detailVC.post = selectedPost
                detailVC.localSource = selectedPost.images
            }
        }
    }
}
