//
//  SignInViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
//    @IBAction func signInButton(_ sender: Any) {
//        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
//
//
//            if(error != nil){
//                let alert = UIAlertController(title: "알림", message: "이미 존재하는 이메일이거나 비밀번호를 6자리 이상 입력하십시오", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//
//
//                return
//
//            }
//
//            let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
        
        signup.addTarget(self, action: #selector(signupEvent), for: .touchUpInside
        )
        cancel.addTarget(self, action: #selector(cancelEvent), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    @objc func imagePicker(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated:true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signupEvent(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){(user, err) in
            if err != nil{
                return
            }
            let uid = Auth.auth().currentUser?.uid
            let image = UIImageJPEGRepresentation(self.imageView.image!, 0.1)
            
            /*
            Storage.storage().reference().child("userImages").child(uid!).putData(image!, metadata: nil, completion: {(data,error) in
                let imageUrl = Storage.storage().reference().child("userImages").child(self.name.text!).fullPath
                Database.database().reference().child("users").child(uid!).setValue(["name":self.name.text!, "profileImageUrl":imageUrl])
            })
            */
            
            
            let storageItem = Storage.storage().reference().child("userImages").child(uid!)
            
            storageItem.putData(image!, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("Couldn't Upload Image")
                } else {
                    print("Uploaded")
                    storageItem.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if url != nil {
                            var imageUrl:String
                            imageUrl = url!.absoluteString
                            Database.database().reference().child("users").child(uid!).setValue(["name":self.name.text!, "profileImageUrl":imageUrl])
                        }
                    }
                )}
            }

            
        }
    }
    @objc func cancelEvent(){
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
