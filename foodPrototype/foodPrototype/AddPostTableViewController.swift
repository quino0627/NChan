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
import DKImagePickerController
import FirebaseStorage



class AddPostTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        super.viewDidLoad()
        
        //getting a reference to the node post
        refPost = Database.database().reference().child("posts");
        
        
    }
    

    @IBOutlet weak var nameTextField: HoshiTextField!
    
    @IBOutlet weak var titleTextField: HoshiTextField!
    
    @IBOutlet weak var priceTextField: HoshiTextField!
    
    @IBOutlet weak var contentText: UITextView!
    
    
    
    @IBAction func addImageClicked(_ sender: Any) {
        
        let pickerController = DKImagePickerController()
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            print(assets)
            for asset in assets{
                print("this is an image: ",asset)
               // let image = extraInfo["image"] as? UIImage
        }
        }
        
        self.present(pickerController, animated: true) {}
        
    }


    @IBAction func save(_ sender: Any) {
        addPost()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //defining firebase reference var
    var refPost: DatabaseReference!
    
    func addPost(){
        //generating a new key inside post node
        //and also getting the generated key
        let key = refPost.childByAutoId().key
        
        //creating artist with the given values
        let post = ["id":key,
                      "postName": nameTextField.text! as String,
                      "postTitle": titleTextField.text! as String,
                      "postPrice": priceTextField.text! as String,
                      "postContent": contentText.text! as String
        ]
        
        //adding the artist inside the generated unique key
        refPost.child(key).setValue(post)
    }

}
