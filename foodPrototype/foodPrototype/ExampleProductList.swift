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

class ProductList{
    var product :String

    init(product :String){
        self.product = product

    }
    
    func toDictionary() -> [String:Any]{
        return ["product":self.product]
    }
    
    init?(_ dictionary :[String:Any]){
        
        guard let product = dictionary["product"] as? String else{
            return nil
        }
        
        self.product = product
        
        
    }
    
}

/*class TitleList{
    var title : String
    
    init(title :String){
        self.title = title
    }
    
}*/

