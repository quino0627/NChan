//
//  UserController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import Firebase

class UserController: UIViewController {

    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch  {
            print("Error")
        }
        dismiss(animated: true, completion: nil)
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
