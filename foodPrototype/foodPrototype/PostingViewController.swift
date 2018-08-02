//
//  PostingViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//
import Foundation
import UIKit

protocol PostingViewControllerDelegate{
    func postingViewControllerIsDone(controller: UIViewController, title: String)
   // func postingViewControllerDidCancel(controller: UIViewController)
}

class PostingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBOutlet weak var productTextField: HoshiTextField!
    var delegate :PostingViewControllerDelegate!
    
    @IBOutlet weak var titleTextField: HoshiTextField!
    
    
    @IBOutlet weak var tagTextField: HoshiTextField!
    
    @IBOutlet weak var priceTextField: HoshiTextField!
    
    @IBOutlet weak var contentsTextField: JSQMessagesComposerTextView!
    
    @IBAction func done(_ sender: Any) {
        if let title = self.titleTextField.text{
            self.delegate.postingViewControllerIsDone(controller: self, title: title)
            
        }
    }
    
    
    


    
    
    
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
