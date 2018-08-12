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

class JointPurchaseViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var buyingTable: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var refreshControl: UIRefreshControl!
    
    //about search
    var filteredData: [ExampleFirePost] = []
    
    //    var uid : String?
    var buyingPosts : [ExampleFirePost] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯.
    let refPost = Database.database().reference().child("posts")

    //about searchB
    func searchBar(_ searchbar: UISearchBar, textDidChange searchText: String){
        filteredData = searchText.isEmpty ? buyingPosts : buyingPosts.filter({ (buyingPosts) -> Bool in
            return buyingPosts.product?.range(of: searchText, options: .caseInsensitive) != nil
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
    
    @objc func refresh(_ sender: AnyObject) {
        print("refresh table")
        self.buyingPosts.removeAll()
        
        load_buyingList_data()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell

        let item = filteredData[indexPath.row]
        cell.listProduct.text = item.product
        cell.listPrice.text = item.price
        cell.listPlace.text = item.wishLocation
        cell.listTime.text = nil
        let data = try? Data(contentsOf: URL(string: (item.images?.first?.value)!)!) //물어보기
        cell.listImage.image = UIImage(data: data!)

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //about search
        self.buyingTable.dataSource = self
        self.buyingTable.delegate = self
        self.searchbar.delegate = self
        self.searchbar.placeholder = " 상품이름을 입력하세요"
        
        // set up the refresh control
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        //Swift3에서부터는 action사용 시 #selector가 필요.//
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: UIControlEvents.valueChanged)
        
        buyingTable.addSubview(refreshControl) //리플래시 화면을 보일(빙글빙글 돌아가는 프로그래스바)뷰를 장착.//
        
        load_buyingList_data()

    }

    
    func load_buyingList_data(){
        
        if(self.buyingPosts.count != 0){
            print("refresh table")
            
            buyingTable.reloadData() //뷰를 재로드//
            
            refreshControl.endRefreshing() //다시 새로고침을 끝낸다.//
        }
            
        else{
            
            refPost.observe(DataEventType.value, with: { (snapshot) in

                //if the reference have some values
                if snapshot.childrenCount > 0{
                    
                    
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

                        Database.database().reference().child("users").child(postUid as! String).observe(DataEventType.value, with: { (snapshot) in
                            let pchild = snapshot.value as? [String: AnyObject]
                            let pUser = UserModel()
                            
                            pUser.name = pchild?["name"] as? String
                            pUser.profileImageUrl = pchild?["profileImageUrl"] as? String
                            pUser.uid = pchild?["uid"] as? String
                            let post = ExampleFirePost(images: postImagesUrl ,id: postId as! String?, product: postProduct as! String?, content: postContent as! String?, maxMan: postMaxMan as! String?, price: postPrice as! String?, wishLocation: postWishLocation as! String?, user: pUser)
                            
                            
                            self.buyingPosts.append(post)
                            
                            self.filteredData = self.buyingPosts
                            
                            self.buyingTable.reloadData()
                            
                            self.refreshControl.endRefreshing()
                        })
                        
                    }
                    
                }
            })

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = buyingTable.indexPathForSelectedRow,
            let detailVC = segue.destination as? PostViewController {
            let selectedPost :ExampleFirePost = filteredData[indexPath.row]
            detailVC.post = selectedPost
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        load_buyingList_data()
//
//    }
}
