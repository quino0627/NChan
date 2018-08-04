//
//  ChatViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 4..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIButton!
    
    var uid : String?
    var chatRoomUid: String?
    
    
    public var destinationUid: String? //나중에 내가 채팅할 대상의 uid
    override func viewDidLoad() {
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        sendButton.addTarget(self, action: #selector(createRoom), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func createRoom(){
        let createRoomInfo:Dictionary<String, Any> = [
//            "uid":Auth.auth().currentUser?.uid,
//            "destinationUid":destinationUid
            "users":[
                uid!: true,
                destinationUid!:true
            ]
                
//
        ]
        Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo)
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
