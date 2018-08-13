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
    var filteredData: [PostModel] = []
    
    //    var uid : String?
    var buyingPosts : [PostModel] = [] //post에 성공, 진행중, 실패에 대한 변수 넣어야 할듯.
    let refPost = Database.database().reference().child("posts")

    //about searchB
    func searchBar(_ searchbar: UISearchBar, textDidChange searchText: String){
        filteredData = searchText.isEmpty ? buyingPosts : buyingPosts.filter({ (buyingPosts) -> Bool in
            return buyingPosts.postProduct?.range(of: searchText, options: .caseInsensitive) != nil
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
        let url = URL(string: (item.ImageUrl.first?.value)!)
        cell.listProduct.text = item.postProduct
        cell.listPrice.text = item.postPrice
        cell.listPlace.text = item.postWishLocation
        cell.listTime.text = nil
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
            DispatchQueue.main.sync {
                cell.listImage.image = UIImage(data: data!)
            }
        }).resume()
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
                        
                        let postProduct = PostModel(JSON: postObject!)
                        
                        self.buyingPosts.append(postProduct!)
                            
                            self.filteredData = self.buyingPosts
                            
                            self.buyingTable.reloadData()
                            
                            self.refreshControl.endRefreshing()
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
            let selectedPost :PostModel = filteredData[indexPath.row]
            detailVC.post = selectedPost
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        load_buyingList_data()
//
//    }
}
