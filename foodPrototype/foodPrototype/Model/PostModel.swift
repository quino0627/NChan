//
//  PostModel.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

//need to be updated

import Foundation

class PostModel{
    var id: String?
    var product: String?
    var content: String?
    var price: String?
    var maxMan: String?
    var uid: String?
    var wishLocation: String? //needs to be changed into array
    
    init (id: String?, product: String?, content: String?, price: String?, uid: String?, maxMan: String?, wishLocation: String?){
        
        self.id = id //post id
        self.product = product
        self.uid = uid //user id
        self.maxMan = maxMan
        self.content = content
        self.price = price
        self.wishLocation = wishLocation

        
    }
    

}
