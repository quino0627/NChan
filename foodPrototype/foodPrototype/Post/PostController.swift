//
//  PostController.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 13..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class PostController: UIViewController {

    @IBOutlet weak var food_Price: UILabel!
    @IBOutlet weak var InviteButton: UIButton!
    @IBOutlet weak var container : UIView!
    var post: PostModel?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        food_Price.text = post?.postPrice
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InviteButton.addTarget(self, action: #selector(touchedButton), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func touchedButton(){
        print("포스트 아이디 프린트")
        print(post?.id as Any)
        var myUid = Auth.auth().currentUser?.uid
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "postId").queryEqual(toValue: post?.id).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            let value = datasnapshot.value as? NSDictionary
            //let userList = value?["users"]
            let chatroomKey = value?.allKeys[0] as! String
            //let originChatMember = value?.value(forKey: chatroomKey)
            let inputValue:Dictionary<String,Any> = [myUid!:true]
            Database.database().reference().child("chatrooms").child(chatroomKey).child("users").observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
                var originChatMember = datasnapshot.value as? NSMutableDictionary
                originChatMember![myUid] = true
                //                print("챗룸 데이터스냅샷")
                //                print(originChatMember)
                //                print(type(of: originChatMember))
                var enterMessage:Dictionary<String, Any> = [
                    "message": "입장하였습니다.",
                    "timestamp":ServerValue.timestamp(),
                    "uid":myUid
                ]
                Database.database().reference().child("chatrooms").child(chatroomKey).child("users").setValue(originChatMember)
                Database.database().reference().child("chatrooms").child(chatroomKey).child("comments").childByAutoId().setValue(enterMessage)
                let view = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                view.destinationRoom = chatroomKey
                self.navigationController?.pushViewController(view, animated: true)
            })
            //
            print("start")
            //print(userList)
            //print(originChatMember)
            //print(value?.allKeys[0] as! String)
            //            print(type(of: datasnapshot))
            //            print(type(of: datasnapshot.value))
            print("datasnapshot")
        })
        
        //users[myUid!] = true
    }
    

}
