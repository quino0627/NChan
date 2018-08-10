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
import ImageSlideshow

class JointPurchaseViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var buyingTable: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    //about search
    var filteredData: [String]!
    var product_name_array = [String]()
    
    //    var uid : String?
    var buyingPosts : [ExampleFirePost] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯.
    let refPost = Database.database().reference().child("posts")

    //about searchB
    func searchBar(_ searchbar: UISearchBar, textDidChange searchText: String){
        filteredData = searchText.isEmpty ? product_name_array : product_name_array.filter({ (dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        buyingTable.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchbar.showsCancelButton = true //취소버튼 보이기
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.showsCancelButton = false
        self.searchbar.text = ""
        self.searchbar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search text: ", self.searchbar.text!)
        
        let refreshAlert = UIAlertController(title: "검색결과", message: self.searchbar.text!, preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action: UIAlertAction!) in
            print("검색확인")
            
            self.searchbar.showsCancelButton = false
            self.searchbar.text = ""
            self.searchbar.resignFirstResponder()
        }))
        
        present(refreshAlert, animated: true, completion: nil) // 작성된 다이얼로그 생성
    }
    
    func refresh(_ sender: AnyObject) {
        print("refresh table")
        
        self.product_name_array.removeAll()
        
        buyingTable.reloadData()
        
        //여기서부터 다시해야함
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell

        let item = buyingPosts[indexPath.row]
        cell.listProduct.text = item.product
        cell.listPrice.text = item.price
        cell.listPlace.text = item.wishLocation
        cell.listTime.text = nil
        let data = try? Data(contentsOf: URL(string: (item.user!.profileImageUrl!))!)
        cell.listImage.image = UIImage(data: data!)

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
        
        //about search
        self.buyingTable.dataSource = self
        self.buyingTable.delegate = self
        self.searchbar.delegate = self
        self.searchbar.placeholder = " 상품이름을 입력하세요"
        
        self.filteredData = self.product_name_array
        
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
                        
                        self.product_name_array.append(postProduct as! String)
                        self.buyingPosts.append(post)
                        
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
        
        if let indexPath = buyingTable.indexPathForSelectedRow,
            let detailVC = segue.destination as? PostViewController {
            let selectedPost :ExampleFirePost = buyingPosts[indexPath.row]
            detailVC.post = selectedPost
        }
    }
}
