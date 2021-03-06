//
//  ChatModel.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 4..
//  Copyright © 2018년 송. All rights reserved.
//

import ObjectMapper


class ChatModel: Mappable {
   
    
//    var uid:String?
//    var destinationUid:String?
   
    
    public var users:Dictionary<String, Bool> = [:]
    //채팅방에 참여한 사람들
    public var comments : Dictionary<String, Comment> = [:]
    
    public var postId:String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        users <- map["users"]
        comments <- map["comments"]
        postId <- map["postId"]
    }
    //채팅방의 대화내용
    public class Comment :Mappable{
        public var uid : String?
        public var message : String?
        public var timestamp: Int?
        public var readUsers : Dictionary<String,Bool> = [:]
        public required init?(map: Map){
            
        }
        
        public func mapping(map: Map){
            uid <- map["uid"]
            message <- map["message"]
            timestamp <- map["timestamp"]
            readUsers <- map["readUsers"]
        }
        
    }
}
