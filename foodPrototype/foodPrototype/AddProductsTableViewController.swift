//
//  AddProductsTableViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//


import UIKit

protocol AddProductsTableViewControllerDelegate {
    
    func addProductsTableViewControllerDidSave(controller :UIViewController, product :String)
    func addProductsTableViewControllerDidCancel(controller :UIViewController)

}


class AddProductsTableViewController: UITableViewController {
    

    @IBOutlet weak var ProductTextField: HoshiTextField!
    var delegate :AddProductsTableViewControllerDelegate!
    
    //    @IBOutlet weak var TitleTextField: HoshiTextField!
    
    @IBAction func save() {
        
    if let product = self.ProductTextField.text {
        self.delegate.addProductsTableViewControllerDidSave(controller: self, product: product)
        }
        
//    if let title = self.TitleTextField.text {
//        self.delegate.addProductsTableViewControllerDidSave(controller: self, product: title)
//        }
        
        
    }
    
    
    @IBAction func cancel() {
        self.delegate.addProductsTableViewControllerDidCancel(controller: self)
    }

}
