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
    var name: String?
    var title: String?
    var content: String?
    var price: String?
    
    init (id: String?, name: String?, title: String?, content: String?, price: String? ){
        
        self.id = id
        self.name = name
        self.title = title
        self.content = content
        self.price = price
        
    }
    

}
