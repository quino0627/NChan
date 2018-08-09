//
//  JointPurchaseViewController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 9..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class JointPurchaseViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var buyingTable: UITableView!

    //    var uid : String?
    var buyingPosts : [ExampleFirePost] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯.
    let refPost = Database.database().reference().child("posts")

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyingPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell

        let item = buyingPosts[indexPath.row]
        //            cell.listImage.image = nil
        cell.listProduct.text = item.product
        cell.listPrice.text = item.price
        cell.listPlace.text = item.wishLocation
        cell.listTime.text = nil
//        let data = try? Data(contentsOf: URL(string: (item.user!.profileImageUrl!))!)
//        cell.listImage.image = UIImage(data: data!)
        //            print(item.user?.name)
        //            print("HIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHIHI")
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

                //clearing list
                self.buyingPosts.removeAll()

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
                    var post = ExampleFirePost(id: postId as! String?, product: postProduct as! String?, content: postContent as! String?, maxMan: postMaxMan as! String?, price: postPrice as! String?, wishLocation: postWishLocation as! String?, user: nil)
                    Database.database().reference().child("users").observe(DataEventType.value, with: { (snapshot) in
                        for user in snapshot.children.allObjects as! [DataSnapshot]{
                            let pchild = user.value as? [String:AnyObject]
                            let pUser = ExampleFireUser()
                            if pchild!["uid"] as! String == postUid as! String{
                                pUser.name = pchild?["name"] as? String
                                pUser.profileImageUrl = pchild?["profileImageUrl"] as? String
                                pUser.uid = pchild?["uid"] as? String
                                post.user = pUser
                                print(post.user?.name)
                            }
                        }
                    })
                    //creating post object with model and fetched values
                    self.buyingPosts.append(post)
                }

                //reloading the tableview
                self.buyingTable.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = buyingTable.indexPathForSelectedRow,
            let detailVC = segue.destination as? PostViewController {
            let selectedPost :ExampleFirePost = buyingPosts[indexPath.row]
            detailVC.post = selectedPost
        }
    }
}
