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

class BuyingListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var buyingTable: UITableView!

    var buyingPosts : [PostModel] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯.
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
            cell.listProduct.text = item.postProduct
            cell.listPrice.text = item.postPrice
            cell.listPlace.text = item.postWishLocation
            cell.listTime.text = nil
            let data = try? Data(contentsOf: URL(string: (item.ImageUrl.first?.value)!)!)
            cell.listImage.image = UIImage(data: data!)
            return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refPost.observe(DataEventType.value, with: { (snapshot) in

            //if the reference have some values
            if snapshot.childrenCount > 0{

                //clearing list
                    self.buyingPosts.removeAll()
                
                //iterating through all the values
                for posts in snapshot.children.allObjects as! [DataSnapshot]{
                    //getting values
                    let postObject = posts.value as? [String: AnyObject]
                    
                    let postProduct = PostModel(JSON: postObject!)

                    self.buyingPosts.append(postProduct!)
                    
                    self.buyingTable.reloadData()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost :PostModel = buyingPosts[indexPath.row]
                detailVC.post = selectedPost
            }
    }
}
