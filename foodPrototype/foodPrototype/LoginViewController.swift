//
//  LoginViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit


class LoginViewController: UIViewController , GIDSignInUIDelegate, FBSDKLoginButtonDelegate{
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult?, error: Error) {
        if(result?.token == nil){
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            // ...
        }
        FBSDKLoginManager().logOut();
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    @IBAction func googleSignIn(_ sender: Any) {
         GIDSignIn.sharedInstance().signIn()
    }
    
    
    let remoteconfig = RemoteConfig.remoteConfig()
    var color : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! Auth.auth().signOut()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        facebookLoginButton.delegate = self
 
        let statusBar = UIView()
        self.view.addSubview(statusBar)
        statusBar.snp.makeConstraints{(m) in
        m.right.top.left.equalTo(self.view)
        m.height.equalTo(20)
        }
        
        color = remoteconfig["splash_background"].stringValue
        
        statusBar.backgroundColor = UIColor(hex: color)
        loginButton.backgroundColor = UIColor(hex: color)
        signIn.backgroundColor = UIColor(hex: color)
        
        signIn.addTarget(self, action: #selector(presentsignup), for:.touchUpInside)
        // Do any additional setup after loading the view.
        loginButton.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        
        Auth.auth().addStateDidChangeListener{(auth, user) in
        if(user != nil){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "MainViewTabBarController") as! UITabBarController
            self.present(view, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func presentsignup(){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignInViewController
        self.present(view, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loginEvent(){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!){(user, err) in
            if (err != nil){
                let alert = UIAlertController(title: "에러", message: err.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
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
