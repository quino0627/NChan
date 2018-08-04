//
//  AddProductsTableViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//


import UIKit

protocol AddProductsTableViewControllerDelegate {
    
    func addProductsTableViewControllerDidSave(controller :UIViewController, product : Product)
    func addProductsTableViewControllerDidCancel(controller :UIViewController)

}


class AddProductsTableViewController: UITableViewController {
    


    @IBOutlet weak var nameTextField: HoshiTextField!
    var delegate :AddProductsTableViewControllerDelegate!
    
    @IBOutlet weak var titleTextField: HoshiTextField!
    
    @IBOutlet weak var priceTextField: HoshiTextField!
    
    @IBAction func save() {
        var product = Product(name: nameTextField.text!, title: titleTextField.text!, price: priceTextField.text!)
        
        if let _ = self.nameTextField, let _ = self.titleTextField, let _ = self.priceTextField{
        self.delegate.addProductsTableViewControllerDidSave(controller: self, product: product)
        }
        
    }
    
    
    @IBAction func cancel() {
        self.delegate.addProductsTableViewControllerDidCancel(controller: self)
    }

}
