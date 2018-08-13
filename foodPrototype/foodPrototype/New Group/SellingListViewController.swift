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
    var sellingPosts : [PostModel] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯, 진행중/ 완료일때에 따른 변수 넣기
    var soldPosts : [PostModel] = []
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
            cell.listProduct.text = item.postProduct
            cell.listPrice.text = item.postPrice
            cell.listPlace.text = item.postWishLocation
            cell.listTime.text = nil
            let data = try? Data(contentsOf: URL(string: (item.ImageUrl.first?.value)!)!)
            cell.listImage.image = UIImage(data: data!)
        }
        else{
            let item = soldPosts[indexPath.row]
            cell.listProduct.text = item.postProduct
            cell.listPrice.text = item.postPrice
            cell.listPlace.text = item.postWishLocation
            cell.listTime.text = nil
            let data = try? Data(contentsOf: URL(string: (item.ImageUrl.first?.value)!)!)
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

        refPost.observe(DataEventType.value, with: { (snapshot) in

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
                //iterating through all the values
                for posts in snapshot.children.allObjects as! [DataSnapshot]{
                    //getting values
                    let postObject = posts.value as? [String: AnyObject]
                    
                    let postProduct = PostModel(JSON: postObject!)
                        
                        
                        if self.segmentedControl.selectedSegmentIndex == 0{
                            self.sellingPosts.append(postProduct!)
                        }
                        else{
                            self.soldPosts.append(postProduct!)
                        }
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
        if segmentedControl.selectedSegmentIndex == 0{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost :PostModel = sellingPosts[indexPath.row]
                detailVC.post = selectedPost
            }
        }
        else{
            if let indexPath = buyingTable.indexPathForSelectedRow,
                let detailVC = segue.destination as? PostViewController {
                let selectedPost :PostModel = soldPosts[indexPath.row]
                detailVC.post = selectedPost
            }
        }
    }
}
