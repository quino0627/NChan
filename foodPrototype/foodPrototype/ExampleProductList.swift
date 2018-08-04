//
//  ExampleProductList.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Product {
    var name: String
    var price: String
    var title: String
    
    
    init(name :String, title :String, price :String){
        self.name = name
        self.title = title
        self.price = price
    }
    
    func toDictionary() -> [String:Any]{
        return ["name":self.name as Any, "title": self.title as Any, "price": self.price as Any]
    }
    
    init?(_ dictionary :[String:Any]){
        
        guard let name = dictionary["name"] as? String else{
            return nil
        }
        
        guard let price = dictionary["price"] as? String else{
            return nil
        }
        
        guard let title = dictionary["title"] as? String else{
            return nil
        }
        
        self.name = name
        self.price = price
        self.title = title
        
        
    }
    
    
}


/*struct ProductList{
    var name: String
    var price: String
    var title: String
    var products :[Product] = [Product]()
    

    
    
    
}*/



