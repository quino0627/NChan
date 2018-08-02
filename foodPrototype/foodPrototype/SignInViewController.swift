//
//  SignInViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBAction func SignIn(_ sender: Any) {
    }
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func signInButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            
            
            if(error != nil){return}
            
            let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
