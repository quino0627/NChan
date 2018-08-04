//
//  PostingViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//
import Foundation
import UIKit

class PostingViewController: UIViewController {

    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var titleTextField: HoshiTextField!
    @IBOutlet weak var priceTextField: HoshiTextField!
    
    @IBAction func save(_ sender: Any) {
        controller.dismiss(animated: true, completion: nil)
        let productList = Product(name :product.name, title :product.title, price :product.price)
        self.productLists.append(productList)
        
        let childRef = self.rootRef.child(productList.name)
        
        childRef.setValue(productList.toDictionary()) //firebase
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
