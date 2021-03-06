//
//  PostModel.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

//need to be updated

import UIKit
import ObjectMapper

class PostModel: Mappable{
    required init?(map: Map) {
    }
    
    public var id: String?
    public var postContent: String?
    public var postPrice: String?
    public var postMaxMan: String?
    public var postProduct: String?
    public var uid: String?
    public var postWishLocation: String? //needs to be changed into array
    public var ImageUrl:Dictionary<String,String> = [:]
    
    public func mapping(map: Map){
        id <- map["id"]
        postContent <- map["postContent"]
        postPrice <- map["postPrice"]
        postMaxMan <- map["postMaxMan"]
        uid <- map["uid"]
        postWishLocation <- map["postWishLocation"]
        ImageUrl <- map["ImageUrl"]
        postProduct <- map["postProduct"]
    }
    
    
    public class Image : Mappable{
        public var imageUrl : Dictionary<String, String> = [:]
        public required init?(map: Map) {
        }
        public func mapping(map: Map){
            imageUrl <- map["imageUrl"]
        }
    }
    

}
