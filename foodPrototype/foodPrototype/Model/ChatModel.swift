//
//  ChatModel.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 4..
//  Copyright © 2018년 송. All rights reserved.
//

import ObjectMapper


class ChatModel: Mappable {
    func mapping(map: Map) {
        
    }
    
//    var uid:String?
//    var destinationUid:String?
    public var users:Dictionary<String, Bool> = [:]
    //채팅방에 참여한 사람들
    public var comments : Dictionary<String, Comment> = [:]
    required init?(map: Map) {
        users <- map["users"]
        comments <- map["comments"]
    }
    
    //채팅방의 대화내용
    public class Comment :Mappable{
        public var uid : String?
        public var message : String?
        public required init?(map: Map){
            
        }
        public func mapping(map: Map){
            uid <- map["uid"]
            message <- map["message"]
        }
        
    }
}
