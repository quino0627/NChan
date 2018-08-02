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

struct comment{
    var commentDate: Time
    var commentWriter:user
    var commentContent:String
    var commentReplyArray = Array<comment>()
}

struct productInfo{
    var productPicArray = Array<String>()
    var productType: foodType
    var productExplanation: String
    var price : String //Int 중에 고민중
}

struct post {
    var postDate: Time
    var postWriter: user
    var postType : postClassify
    var postTitle:String
    var postContent:productInfo
    var postCommentArray = Array<comment>()
    var postTag = Array<String>()
}

struct user {
    var userName:String
    var userNickname:String
    var userImage: String
    var userId:String
    var userPassword:String
    var schoolCertification:Bool
    var sellHistory = Array<post>()
    var buyHispory = Array<post>()
    var myWritingHistory = Array<post>()
    var myWishList = Array<post>()
    var belongingChatRoomArray = Array<chatRoom>()
    var userReliability: UserSafety
    // 신고추가
}

struct UserSafety {
    var value : Int
    var face: String {
        get{
            if value > 100 {
                return "my_goodgood"
            }
            else {
                return "my_good"
            }
        }
    }
    var state : String {
        get{
            if value > 100 {
                return "매우 좋음"
            }
            else {
                return "좋음"
            }
        }
    }
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
