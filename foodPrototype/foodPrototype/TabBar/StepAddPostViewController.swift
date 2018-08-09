//
//  ViewController.swift
//  StepIndicator
//
//  Created by Yun Chen on 2017/7/14.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit
import SnapKit

class StepAddPostViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var stepIndicatorView:StepIndicatorView!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    
    var s_Scrollview_0 = UIScrollView()
    var s_Scrollview_1 = UIScrollView()
    var s_Scrollview_2 = UIScrollView()
    
    var ss_listView_0 = UIView()
    var ss_listView_1 = UIView()
    var ss_listView_2 = UIView()
    var ss_listView_3 = UIView()
    var ss_listView_4 = UIView()
    
    var sss_listText_content = UILabel()
    var sss_listText_maxMan = UILabel()
    var sss_listText_Price = UILabel()
    var sss_listInput_content = UITextField()
    var sss_listInput_maxMan = UITextField()
    var sss_listInput_Price = UITextField()
    
    var sss_listText_hopePlace = UILabel()
    var sss_listText_more = UILabel()
    var sss_listInput_hopePlace = UITextField()
    var sss_listInput_more = UITextField()
    
    
    
    // 뷰 전체 폭 길이
    let screenWidth = UIScreen.main.bounds.size.width
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    //서브 스크롤뷰 개수
    let count = 3
    
    private var isScrollViewInitialized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Customization by coding:
        //self.stepIndicatorView.numberOfSteps = 5
        //self.stepIndicatorView.currentStep = 0
        //self.stepIndicatorView.circleColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        //self.stepIndicatorView.circleTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
        //self.stepIndicatorView.circleStrokeWidth = 3.0
        //self.stepIndicatorView.circleRadius = 10.0
        //self.stepIndicatorView.lineColor = self.stepIndicatorView.circleColor
        //self.stepIndicatorView.lineTintColor = self.stepIndicatorView.circleTintColor
        //self.stepIndicatorView.lineMargin = 4.0
        //self.stepIndicatorView.lineStrokeWidth = 2.0
        //self.stepIndicatorView.displayNumbers = false //indicates if it displays numbers at the center instead of the core circle
        //self.stepIndicatorView.direction = .leftToRight
        
        s_Scrollview_0.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 510)
        s_Scrollview_0.backgroundColor = UIColor(hex: "#2980b9")
        
        s_Scrollview_1.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: 510)
        s_Scrollview_1.backgroundColor = UIColor(hex: "#2ecc71")
        
        s_Scrollview_2.frame = CGRect(x: screenWidth * 2, y: 0, width: screenWidth, height: 510)
        s_Scrollview_2.backgroundColor = UIColor(hex: "#34495e")
        
        ss_listView_0.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/2 )
        ss_listView_1.frame = CGRect(x: 0, y: 100, width:screenWidth, height : screenHeight/2 )
        ss_listView_2.frame = CGRect(x: 0, y: 200, width: screenWidth, height: screenHeight/2 )
        ss_listView_3.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/2 )
        ss_listView_4.frame = CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight/2 )
        
        sss_listText_content.frame = CGRect(x: 10,y: 10, width: 200, height: 25)
        sss_listText_content.text = "공구하고자 하는 물건"
        sss_listText_content.font = sss_listText_content.font.withSize(20)
        sss_listText_maxMan.frame = CGRect(x: 10, y: 10, width:200, height:25)
        sss_listText_maxMan.text = "최대 인원수"
        sss_listText_maxMan.font = sss_listText_maxMan.font.withSize(20)
        sss_listText_Price.frame = CGRect(x: 10, y: 10, width: 200, height: 25)
        sss_listText_Price.text = "예상 가격"
        sss_listText_Price.font = sss_listText_Price.font.withSize(20)
        
        sss_listText_hopePlace.frame = CGRect(x: 10, y: 10, width: 200, height: 25)
        sss_listText_hopePlace.text = "거래를 희망하는 장소(선택 사항)"
        sss_listText_hopePlace.font = sss_listText_Price.font.withSize(20)
        sss_listText_more.frame = CGRect(x: 10, y: 10, width: 200, height: 25)
        sss_listText_more.text = "추가 설명(선택 사항)"
        sss_listText_more.font = sss_listText_Price.font.withSize(20)
        
        sss_listInput_content.frame = CGRect(x: 0, y: 50, width: 200, height: 25)
        sss_listInput_content.placeholder = "Sample Placeholder1"
        sss_listInput_maxMan.frame = CGRect(x: 0, y: 50, width: 200, height: 25)
        sss_listInput_maxMan.placeholder = "Sample Placeholder2"
        sss_listInput_Price.frame = CGRect(x: 0, y: 50, width: 200, height: 25)
        sss_listInput_Price.placeholder = "Sample Placeholder3"
        
        sss_listInput_hopePlace.frame = CGRect(x: 0, y: 50, width: 200, height: 25)
        sss_listInput_hopePlace.placeholder = "Sample Placeholder4"
        sss_listInput_more.frame = CGRect(x: 0, y: 50, width: 200, height: 25)
        sss_listInput_more.placeholder = "Sample Placeholder5"
        
        ss_listView_0.addSubview(sss_listText_content)
        ss_listView_1.addSubview(sss_listText_maxMan)
        ss_listView_2.addSubview(sss_listText_Price)
        ss_listView_0.addSubview(sss_listInput_content)
        ss_listView_1.addSubview(sss_listInput_maxMan)
        ss_listView_2.addSubview(sss_listInput_Price)
        
        ss_listView_3.addSubview(sss_listText_hopePlace)
        ss_listView_4.addSubview(sss_listText_more)
        ss_listView_3.addSubview(sss_listInput_hopePlace)
        ss_listView_4.addSubview(sss_listInput_more)
        
        
        s_Scrollview_0.addSubview(ss_listView_0)
        s_Scrollview_0.addSubview(ss_listView_1)
        s_Scrollview_0.addSubview(ss_listView_2)
        
        s_Scrollview_1.addSubview(ss_listView_0)
        s_Scrollview_1.addSubview(ss_listView_1)
        s_Scrollview_1.addSubview(ss_listView_2)
        
        s_Scrollview_2.addSubview(ss_listView_3)
        s_Scrollview_2.addSubview(ss_listView_4)
        
        
        scrollView.addSubview(s_Scrollview_0)
        scrollView.addSubview(s_Scrollview_1)
        scrollView.addSubview(s_Scrollview_2)
        
        
        
        
        s_Scrollview_1.contentSize = CGSize(width: screenWidth, height: screenHeight * 1.5)
        s_Scrollview_2.contentSize = CGSize(width: screenWidth, height: screenHeight * 1.5)
        
        scrollView.contentSize = CGSize(width: screenWidth * 3, height: screenHeight / 2)
        scrollView.isPagingEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isScrollViewInitialized {
            isScrollViewInitialized = true
            self.initScrollView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initScrollView() {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(self.stepIndicatorView.numberOfSteps + 1), height: self.scrollView.frame.height)
        for i in 1...self.stepIndicatorView.numberOfSteps + 1 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
            
            if i == 1 {
                label.text = "Image Picker"
                //함수화
            }
            else if i==2 {
                label.text = ""
            }
            else if i==3{
                label.text = "희망 구매 사이트, 회망 거래 위치, 추가 기술"
            }
            else{
                label.text = "Done"
            }

            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 35)
            label.textColor = UIColor(hex: "#ecf0f1")
            label.center = CGPoint(x: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0), y: self.scrollView.frame.height / 2.0)
            self.scrollView.addSubview(label)
        }
    }
    
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        stepIndicatorView.currentStep = Int(pageIndex)
    }
    
    func didDoneButtonPressed(){
        if(){
            
        }
        else{
            dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
    }
    
}


