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

class LoginViewController: UIViewController , GIDSignInUIDelegate{
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    @IBAction func googleSignIn(_ sender: Any) {
         GIDSignIn.sharedInstance().signIn()
    }
    
    let remoteconfig = RemoteConfig.remoteConfig()
    var color : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().uiDelegate = self
       
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
