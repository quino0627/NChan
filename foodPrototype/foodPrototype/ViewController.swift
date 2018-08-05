//
//  ViewController.swift
//  foodPrototype
//
//  Created by 송 on 2018. 8. 1..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {
    var box = UIImageView()
    var remoteConfig:RemoteConfig!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = RemoteConfigSettings(developerModeEnabled: true)
        
        //서버가 연결되지 않았을 때 이 값을 쓴다.
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")

        
        //        서버값을 받는 부분
        remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activateFetched()
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            self.displayWelcome()
        }

        
        
        self.view.addSubview(box)
        // Do any additional setup after loading the view.
        box.snp.makeConstraints{(make) in
            make.center.equalTo(self.view)}
        box.image = #imageLiteral(resourceName: "loading_icon")
    }

    func displayWelcome(){
        let color = remoteConfig["splash_background"].stringValue
        let caps = remoteConfig["splash_message_caps"].boolValue
        let message = remoteConfig["splash_message"].stringValue
        if(caps){
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: {(action) in exit(0)}))
            self.present(alert, animated: true, completion: nil)
        }else{
            let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainViewTabBarController") as! UITabBarController
            self.present(mainView, animated: false, completion: nil)
        }
        self.view.backgroundColor = UIColor(hex: color!)
        
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
    
    // hex = "FF0000"
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
