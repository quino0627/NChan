//
//  ChatRoomsViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 5..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    var uid: String!
    var chatrooms : [ChatModel]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = Auth.auth().currentUser?.uid
        self.getChatroomsList()
        // Do any additional setup after loading the view.
    }

    
    
    func getChatroomsList(){
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                self.chatrooms.removeAll()//데이터가 쌓이는 것을 방지하는 코드
                if let chatroomdic = item.value as? [String:AnyObject]{
                    let chatModel = ChatModel(JSON: chatroomdic)
                    self.chatrooms.append(chatModel!)
                }
            }
            self.tableview.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! CustomCell
        
        //두번째동영상
        //상대에 대한 정보 가져오기
        var destinationUid :String?
        for item in chatrooms[indexPath.row].users {
            if(item.key != self.uid){
                destinationUid = item.key
            }
        }
        Database.database().reference().child("users").child(destinationUid!).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            //상대방 정보 가져오는 코드
            let userModel = UserModel()
            //1차원으로 된 정보는 아래 코드로 한번에 담을 수 있지만 2차 3차의 경우 objectmapper을 써야 한다.
            userModel.setValuesForKeys(datasnapshot.value as! [String:AnyObject])
            
            
            cell.label_title.text = userModel.name
            let url = URL(string: userModel.profileImageUrl!)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, err) in
                DispatchQueue.main.sync{
                    cell.imageview.image = UIImage(data:data!)
                    cell.imageview.layer.cornerRadius = cell.imageview.frame.width/2
                    cell.imageview.layer.masksToBounds = true
                }
            }).resume()
            let lastMessagekey = self.chatrooms[indexPath.row].comments.keys.sorted(){$0>$1}//오름차순..(설정안해주면 랜덤)
            cell.label_lastmessage.text = self.chatrooms[indexPath.row].comments[lastMessagekey[0]]?.message
            
        })
        
        return cell
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
    
}
