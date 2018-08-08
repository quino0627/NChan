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
import ImagePicker

class AddPostTableViewController: UITableViewController, ImagePickerDelegate {
    
    var imagePickerController : ImagePickerController!
    var uid: String?
    var timestamp: Double!
    var imageArray : [UIImage] = []
    
    //defining firebase reference var
    var refPost: DatabaseReference!
    var refStorage: StorageReference!
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        return
    }
    
    func doneButtonDidPress (_ imagePicker: ImagePickerController, images: [UIImage]) {
        // print(images)
        for image in images {
            print(image)
            addImage.image = image
            imageArray.append(image)
            
            print("good")
        }

        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        
        addImage.isUserInteractionEnabled = true
    addImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
        
        //getting a reference to the node post
        refPost = Database.database().reference().child("posts");
        refStorage = Storage.storage().reference();
        
    }
    

    @IBOutlet weak var productTextField: HoshiTextField!
    
    @IBOutlet weak var titleTextField: HoshiTextField!
    
    @IBOutlet weak var priceTextField: HoshiTextField!
    
    @IBOutlet weak var contentText: UITextView!
    
    @IBOutlet weak var addImage: UIImageView!
    
    @objc func imagePicker(){
        
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 3
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    /*    @IBAction func addImageClicked(_ sender: Any) {
    
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 3

        present(imagePickerController, animated: true, completion: nil)
    }*/


    @IBAction func save(_ sender: Any) {
        addPost()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
/*    func addPost(){
        //generating a new key inside post node
        //and also getting the generated key
        let key = refPost.childByAutoId().key

        //creating post with the given values
        let post = ["id":key,
                      "postProduct": productTextField.text! as String,
                      "postPrice": priceTextField.text! as String,
                      "postContent": contentText.text! as String,
                      "uid": "",//"uid": uid!,
                      "postMaxMan": "maxMan들어가야함" as String,
                      "postWishLocation": "wishLocation들어가야함" as String
            
        ]
        
        //adding the artist inside the generated unique key
        refPost.child(key).setValue(post)
    }*/
    
    func addPost(){
        
        let key = refPost.childByAutoId().key
        print(key)
        for image in imageArray {
            let refImage = refPost.child("ImageUrl")
            let autoID = refImage.childByAutoId().key
            let childRefStorage = refStorage.child("postImages").child(key)
            let image = UIImageJPEGRepresentation(image, 0.8)

            childRefStorage.putData(image!, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("Couldn't Upload Image")
                } else {
                    print("Uploaded")
                    childRefStorage.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if url != nil {
                            var imageUrl:String
                            imageUrl = url!.absoluteString
                            
                            /*let values = ["name":self.name.text!, "profileImageUrl":imageUrl, "uid":Auth.auth().currentUser?.uid]*/
                            
                            
                            let post = ["id":key,
                                        "postProduct": self.productTextField.text! as String,
                                        "postPrice": self.priceTextField.text! as String,
                                        "postContent": self.contentText.text! as String,
                                        "uid": "",//"uid": uid!,
                                "postMaxMan": "maxMan들어가야함" as String,
                                "postWishLocation": "wishLocation들어가야함" as String
                            ]
                            
                            let imageValue = [autoID : imageUrl]
                            
                            //adding the artist inside the generated unique key
                            self.refPost.child(key).setValue(post)
                            refImage.child(autoID).setValue(imageValue)
                            
                        }
                    }
                    )}
            }
            
            
        }

        }
    }
    
    
    

