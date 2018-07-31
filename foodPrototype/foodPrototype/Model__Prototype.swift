//
//  Model__Prototype.swift
//  foodPrototype
//
//  Created by 송 on 2018. 7. 27..
//  Copyright © 2018년 송. All rights reserved.
//

import Foundation

typealias Time = (Year:Int, Month:Int, Day:Int, Hour:Int, Minute:Int)
enum postClassify {
    case groupBuying
    case directDeal
    case operatorPost
}

enum foodType{
    case banchan
    case fruit
}

enum userState{
    case veryGood
    case good
    case normal
    case bad
    case soBad
}

struct comment{
    var commentDate: Time
    var commentWriter:user
    var commentContent:String
    var commentReplyArray = Array<comment>()
}

struct productInfo{
    var productPicArray = Array<imageFile>()
    var productType: foodType
    var productExplanation: String
    
}

struct post {
    var postDate: Time
    var postWriter: user
    var postType : postClassify
    var postTitle:String
    var postContent:productInfo
    var postLike: Int
    var postCommentArray = Array<comment>()
}

struct imageFile {}

struct user {
    var userName:String
    var userNickname:String
    var userImage:imageFile
    var userId:String
    var userPassword:String
    var schoolCertification:Bool
    var sellHistory = Array<post>()
    var buyHispory = Array<post>()
    var myWritingHistory = Array<post>()
    var myWishList = Array<post>()
    var belongingChatRoomArray = Array<chatRoom>()
    var userReliability: userSafety
    // 신고추가
}

struct userSafety {
    var value : Int
    var state : userState
    var face : userState
}

var groupBuyingPostArray = Array<post>()
var directDealPostArray = Array<post>()
var operatorPostArray = Array<post>()
var chatRoomArray = Array<chatRoom>()

struct chatRoom{
    var chatLeader:user
    var chatMember = Array<user>()
    //채팅 데이터 추가
}
