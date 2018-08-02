//
//  AddProductsTableViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//


import UIKit

protocol AddProductsTableViewControllerDelegate {
    
    func addProductsTableViewControllerDidSave(controller :UIViewController, title :String)
    func addProductsTableViewControllerDidCancel(controller :UIViewController)
    
}


class AddProductsTableViewController: UITableViewController {
    

    @IBOutlet weak var ProductTextField: HoshiTextField!
    var delegate :AddProductsTableViewControllerDelegate!
    
    @IBAction func save() {
        
    if let title = self.ProductTextField.text {
            self.delegate.addProductsTableViewControllerDidSave(controller: self, title: title)
        }
    }
    
    @IBAction func cancel() {
        self.delegate.addProductsTableViewControllerDidCancel(controller: self)
    }


 

}
