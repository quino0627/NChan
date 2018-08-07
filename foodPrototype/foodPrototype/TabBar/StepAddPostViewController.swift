//
//  StepAddPostViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import SnapKit
import StepIndicator

class StepAddPostViewController: UIViewController {
    
    let stepIndicatorView = StepIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.stepIndicatorView.frame = CGRect(x: 0, y: 50, width: 280, height: 100)
        self.view.addSubview(self.stepIndicatorView)
        stepIndicatorView.snp.makeConstraints{(make) in
            
        }
        
        self.stepIndicatorView.numberOfSteps = 3
        self.stepIndicatorView.currentStep = 0
        
        
        
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
