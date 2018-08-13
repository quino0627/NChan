//
//  ChatRoomsViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 5..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var uid: String!
    var chatrooms : [ChatModel]! = []
    var destinationUsers : [String] = []
    var keys : [String] = []
    var postModel:PostModel?
    var postId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = Auth.auth().currentUser?.uid
        self.getChatroomsList()
        self.tableview.reloadData()
        // Do any additional setup after loading the view.
    }

    
    
    func getChatroomsList(){
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            self.chatrooms.removeAll()//데이터가 쌓이는 것을 방지하는 코드
//            print(datasnapshot)
//            print("ㄴ 데이터스냅샷")
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                if let chatroomdic = item.value as? [String:AnyObject]{
//                    print(chatroomdic)
//                    print("ㄴchatroomdic")
                    let chatModel = ChatModel(JSON: chatroomdic)
                    self.keys.append(item.key)
                    self.chatrooms.append(chatModel!)
                    //print(chatModel?.postId as Any)
                    //self.postId = chatModel?.postId
                }
            }
            self.tableview.reloadData()
            //print(self.chatrooms.count)
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! CustomCell
        
        //두번째동영상
        //포스트에 대한 정보 가져오기
        var myUid :String?
        
        self.postId = chatrooms[indexPath.row].postId
        Database.database().reference().child("posts").child(self.postId!).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            //print(datasnapshot)
            //for item in datasnapshot.value.children.allObjects as! [DataSnapshot]{}
            if let postdic = datasnapshot.value as? [String: AnyObject]{
//                print(postdic)
//                print("ㄴ포스트딕")
                self.postModel = PostModel(JSON: postdic)
            }
//            print(self.postModel?.id)
//            print(self.postModel?.postContent)
//            print(self.postModel?.postMaxMan)
//            print(self.postModel?.postPrice)
//            print(self.postModel?.ImageUrl as Any)
//            print(self.postModel?.postContent)
            cell.label_title.text = self.postModel?.postProduct
            
            Database.database().reference().child("posts").child((self.postModel?.id)!).child("ImageUrl").observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
                let value = datasnapshot.value as? NSDictionary
                print(type(of: value))
                print(value?.allValues[0] as! String)
                let url = URL(string: value?.allValues[0] as! String)
                URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
                    DispatchQueue.main.sync {
                        cell.imageview.image = UIImage(data:data!)
                        cell.imageview.layer.cornerRadius = cell.imageview.frame.width/2
                        cell.imageview.layer.masksToBounds = true
                    }
                }).resume()
            })
//            let url = URL(string: postModel?.ImageUrl.value!)
//            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
//                DispatchQueue.main.sync{
//                    cell.imageview.image = UIImage(data:data!)
//                    cell.imageview.layer.cornerRadius = cell.imageview.frame.width/2
//                    cell.imageview.layer.masksToBounds = true
//                }
//            }).resume()
            
        })
        
//        observeSingleEvent(of: DataEventType.value , with: {(datasnapshot) in
//            var postTitle :String?  = ""
//            print(datasnapshot)
//                cell.label_title.text = ""
//            })
        
        for item in chatrooms[indexPath.row].users {
            if(item.key == self.uid){
                myUid = item.key
                destinationUsers.append(myUid!)
            }
        }
        Database.database().reference().child("users").child(myUid!).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            //상대방 정보 가져오는 코드
            let userModel = UserModel() //= UserModel()
            
            //1차원으로 된 정보는 아래 코드로 한번에 담을 수 있지만 2차 3차의 경우 objectmapper을 써야 한다.
            userModel.setValuesForKeys(datasnapshot.value as! [String:AnyObject])
            
            
            //cell.label_title.text = userModel.name
            //cell.label_title.text = postContent
//            let url = URL(string: userModel.profileImageUrl!)
//            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
//                DispatchQueue.main.sync{
//                    cell.imageview.image = UIImage(data:data!)
//                    cell.imageview.layer.cornerRadius = cell.imageview.frame.width/2
//                    cell.imageview.layer.masksToBounds = true
//                }
//            }).resume()
            if(self.chatrooms[indexPath.row].comments.keys.count == 0){
                return
            }
            let lastMessagekey = self.chatrooms[indexPath.row].comments.keys.sorted(){$0>$1}//오름차순..(설정안해주면 랜덤)
            cell.label_lastmessage.text = self.chatrooms[indexPath.row].comments[lastMessagekey[0]]?.message
            let unixTime = self.chatrooms[indexPath.row].comments[lastMessagekey[0]]?.timestamp
            cell.label_timestamp.text = unixTime?.toDayTime
            
        })
        
        return cell
    }
    
    //클릭하면 그 챗방으로 간다
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destinationUid = self.destinationUsers[indexPath.row]
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        view.destinationRoom = self.keys[indexPath.row]
        
//        print(indexPath.row)
        print(self.keys[indexPath.row])
//        print(postModel?.id)
        print("인덱스패쓰")

        self.navigationController?.pushViewController(view, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewDidLoad()
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



class CustomCell: UITableViewCell {
    @IBOutlet weak var label_lastmessage: UILabel!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label_timestamp: UILabel!
    
}
