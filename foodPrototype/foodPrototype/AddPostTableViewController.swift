//
//  AddProductsTableViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class AddPostTableViewController: UITableViewController {
    

    @IBOutlet weak var nameTextField: HoshiTextField!
    
    @IBOutlet weak var titleTextField: HoshiTextField!
    
    @IBOutlet weak var priceTextField: HoshiTextField!
    
    
    

    @IBAction func save(_ sender: Any) {
        addPost()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //defining firebase reference var
    var refPost: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting a reference to the node post
        refPost = Database.database().reference().child("post");
        
    }
    
    
    func addPost(){
        //generating a new key inside post node
        //and also getting the generated key
        let key = refPost.childByAutoId().key
        
        //creating artist with the given values
        let post = ["id":key,
                      "name": nameTextField.text! as String,
                      "title": titleTextField.text! as String,
                      "price": priceTextField.text! as String
        ]
        
        //adding the artist inside the generated unique key
        refPost.child(key).setValue(post)
    }
    
    /*  @IBAction func save() {
        var product = Product(name: nameTextField.text!, title: titleTextField.text!, price: priceTextField.text!)
        
       if let _ = self.nameTextField, let _ = self.titleTextField, let _ = self.priceTextField{
        self.delegate.addPostTableViewControllerDidSave(controller: self, product: product)
        }
        
    }
    
        @IBAction func cancel() {
        self.delegate.addPostTableViewControllerDidCancel(controller: self)
    }*/

}
