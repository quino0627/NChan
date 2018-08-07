//
//  ExampleProductListViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ExampleProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewPosts: UITableView!
    
    var postList = [PostModel]()
    let refPost = Database.database().reference().child("posts")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! ExampleProductListTableViewCell
        
        let post: PostModel
        
        //getting the post of selected position
        post = postList[indexPath.row]
        
        //adding values to labels
        cell.name.text = post.name
        cell.price.text = post.price
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observing the data changes
        refPost.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0{
                
                //clearing list
                self.postList.removeAll()
                
                //iterating through all the values
                for posts in snapshot.children.allObjects as! [DataSnapshot]{
                    //getting values
                    let postObject = posts.value as? [String: AnyObject]
                    let postName = postObject?["postName"]
                    let postId = postObject?["id"]
                    let postContent = postObject?["postContent"]
                    let postPrice = postObject?["postPrice"]
                    let postTitle = postObject?["postTitle"]
                    
                    //creating post object with model and fetched values
                    let post = PostModel(id: postId as! String?, name: postName as! String?, title: postTitle as! String?, content: postContent as! String?, price: postPrice as! String?)
                    
                    //appending it to list
                    self.postList.append(post)
                    
                }
                
                //reloading the tableview
                self.tableViewPosts.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
