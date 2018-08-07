//
//  SettingExampleModel.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

import Foundation

struct ExampleUser{
    var userName: String
    var userImage: String
}

struct ExamplePost {
    //    var postDate: Time
    var postWriter: ExampleUser // 수정
    //    var postType : postClassify
    var postTitle:String
    var postContent: productInfo
    //    var postCommentArray = Array<comment>()
    var postTag = Array<String>()
}

struct ExampleFirePost {
    var id: String?
    var product: String?
    var content: String?
    var maxMan: String?
    var price: String?
    var wishLocation: String?
//    var uploadTime: Strimg?
    var uid: String?
}
