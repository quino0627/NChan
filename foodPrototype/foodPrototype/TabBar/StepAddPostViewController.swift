//
//  ViewController.swift
//  StepIndicator
//
//  Created by Yun Chen on 2017/7/14.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import ImagePicker
import ImageSlideshow

class StepAddPostViewController: UIViewController,UIScrollViewDelegate , ImagePickerDelegate{

    var imagePickerController : ImagePickerController!
    var uid = Auth.auth().currentUser?.uid
    var timestamp: Double!
    var imageArray : [UIImage] = []
    var users = Dictionary<String,Bool>()
    
    //defining firebase reference var
    var refPost: DatabaseReference!
    var refStorage: StorageReference!
    
    @IBOutlet weak var stepIndicatorView:StepIndicatorView!
    @IBOutlet weak var scrollView:UIScrollView!
//    @IBOutlet weak var DoneButton: UIBarButtonItem!
    

    
    //화면안의 버튼 눌렀을때
    @objc func isSavedButtonPressed(){
        
        
        //다 채워졌는지확인
        let isAllInputFilled = sss_listInput_content.text != "" || sss_listInput_maxMan.text != "" || sss_listInput_Price.text != ""
        print("Basdf")
        if (isAllInputFilled) {
            
            let postKeyForChat = addPost()
            //print(postKeyForChat)
            users[uid!] = true
            let nsDic = users as NSDictionary
            let chatValue = ["ZZZZZZZZ":[
                "uid" : uid as Any,
                "message" : "채팅방을 개설합니다.",
                "timestamp" : ServerValue.timestamp()
                ]] as [String : Any]
            let values = ["users": nsDic, "postId": postKeyForChat/*, "comments": chatValue*/] as [String : Any]
            Database.database().reference().child("chatrooms").childByAutoId().setValue(values)
            
            
            self.dismiss(animated: true, completion: nil)
        }else{
            print("QQQQQQQQ")
            
            let alert = UIAlertController(title: "Your Title", message: "필수 항목을 모두 기입해주세요", preferredStyle: UIAlertControllerStyle.alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler : nil)
            alert.addAction(defaultAction)
            

            self.present(alert, animated: true, completion: nil)
        }
        
        
       // self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var s_Scrollview_0 = UIScrollView()
    var s_Scrollview_1 = UIScrollView()
    var s_Scrollview_2 = UIScrollView()
//    var s_Scrollview_3 = UIScrollView()
    
    var ss_listView_0 = UIView()
    var ss_listView_1 = UIView()
    var ss_listView_2 = UIView()
    var ss_listView_3 = UIView()
    var ss_listView_4 = UIView()
    
    //이미지 관련
    var ss_listView_5 = UIView()
    
    var addImage = UIImageView()
    var Image1 = UIImageView()
    var Image2 = UIImageView()
    var Image3 = UIImageView()
    
    var image = UIImage(named: "whitecamera.png")
    
    var image1 = UIImage() as Any
    var image2 = UIImage() as Any
    var image3 = UIImage() as Any
    
    
    

    //addImage.image = image
    
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
    
    //button
//    var ss_listView_6 = UIView()
//    var sss_listButton = UIButton()
    //화면안에 저장 버튼 누르게
    
    
    
    // 뷰 전체 폭 길이
    let screenWidth = UIScreen.main.bounds.size.width
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    //서브 스크롤뷰 개수
    let count = 3
    
    private var isScrollViewInitialized = false
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        return
    }
    
    
    //피커안에 있는거
    func doneButtonDidPress (_ imagePicker: ImagePickerController, images: [UIImage]) {
        // print(images)
        for image in images {
            print(image)
           // addImage.image = image
            imageArray.append(image)
            
            //animating
/*            self.addImage.animationImages = imageArray as? [UIImage];
            self.addImage.animationDuration = 5.0
            self.addImage.startAnimating() */

            print("good")
        }
    
 //       for i in 1 ... imageArray.count {
 //           Image[i].image = imageArray[i]
 //       }
        
        Image1.image = imageArray[0]
        Image2.image = imageArray[1]
        Image3.image = imageArray[2]
        
       // 채팅방 개서ㅕㄹ하는 부분
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        addImage.image = image //초기 이미지
        
        addImage.isUserInteractionEnabled = true
        addImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
        
        //getting a reference to the node post
        refPost = Database.database().reference().child("posts");
        refStorage = Storage.storage().reference();
        
        
        //Customization by coding:
        //self.stepIndicatorView.numberOfSteps = 5
        //self.stepIndicatorView.currentStep = 0
        self.stepIndicatorView.circleColor = UIColor(red: 150.0/255.0, green: 19.0/255.0, blue: 46.0/255.0, alpha: 0.7)
        self.stepIndicatorView.circleTintColor = UIColor(red: 150.0/255.0, green: 19.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        //self.stepIndicatorView.circleStrokeWidth = 3.0
        //self.stepIndicatorView.circleRadius = 10.0
        //self.stepIndicatorView.lineColor = self.stepIndicatorView.circleColor
        self.stepIndicatorView.lineTintColor = self.stepIndicatorView.circleTintColor
        //self.stepIndicatorView.lineMargin = 4.0
        //self.stepIndicatorView.lineStrokeWidth = 2.0
        //self.stepIndicatorView.displayNumbers = false //indicates if it displays numbers at the center instead of the core circle
        //self.stepIndicatorView.direction = .leftToRight
        
        s_Scrollview_0.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (screenHeight/4)*3)
        s_Scrollview_0.backgroundColor = UIColor(hex: "#FFFFFF")
        
        s_Scrollview_1.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: (screenHeight/4)*3)
        s_Scrollview_1.backgroundColor = UIColor(hex: "#FFFFFF")
        
        s_Scrollview_2.frame = CGRect(x: screenWidth * 2, y: 0, width: screenWidth, height: (screenHeight/4)*3)
        s_Scrollview_2.backgroundColor = UIColor(hex: "#FFFFFF")
        
//        s_Scrollview_3.frame = CGRect(x: screenWidth * 2, y: 0, width: screenWidth, height: 510)
//        s_Scrollview_3.backgroundColor = UIColor(hex: "#FFFFFF")
        
        ss_listView_0.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/2 )
        ss_listView_1.frame = CGRect(x: 0, y: 100, width:screenWidth, height : screenHeight/2 )
        ss_listView_2.frame = CGRect(x: 0, y: 200, width: screenWidth, height: screenHeight/2 )
        ss_listView_3.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/2 )
        ss_listView_4.frame = CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight/2 )
        //이미지
        ss_listView_5.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        
        sss_listText_content.frame = CGRect(x: 10,y: 10, width: screenWidth, height: 25)
        sss_listText_content.text = "공구하고자 하는 물건"
        sss_listText_content.font = sss_listText_content.font.withSize(20)
        sss_listText_maxMan.frame = CGRect(x: 10, y: 10, width:screenWidth, height:25)
        sss_listText_maxMan.text = "최대 인원수"
        sss_listText_maxMan.font = sss_listText_maxMan.font.withSize(20)
        sss_listText_Price.frame = CGRect(x: 10, y: 10, width: screenWidth, height: 25)
        sss_listText_Price.text = "예상 가격"
        sss_listText_Price.font = sss_listText_Price.font.withSize(20)
        
        sss_listText_hopePlace.frame = CGRect(x: 10, y: 10, width: screenWidth, height: 25)
        sss_listText_hopePlace.text = "거래를 희망하는 장소(선택 사항)"
        sss_listText_hopePlace.font = sss_listText_Price.font.withSize(20)
        sss_listText_more.frame = CGRect(x: 10, y: 10, width: screenWidth, height: 25)
        sss_listText_more.text = "추가 설명(선택 사항)"
        sss_listText_more.font = sss_listText_Price.font.withSize(20)
        
        
//        sss_listButton.frame = CGRect(x: 10, y: 10, width: 200, height: 25)
//        sss_listButton.setTitle("저장", for: .normal)
//        sss_listButton.backgroundColor = UIColor(hex: "#2ecc71")
//        sss_listButton.addTarget(self, action: #selector(isSavedButtonPressed), for: .touchUpInside)
        //self.view.addSubview(sss_listButton)
        
        
        
        sss_listInput_content.frame = CGRect(x: 10, y: 50, width: screenWidth, height: 25)
        sss_listInput_content.placeholder = "품목을 기입해주세요"
        sss_listInput_maxMan.frame = CGRect(x: 10, y: 50, width: screenWidth, height: 25)
        sss_listInput_maxMan.placeholder = "최대 인원을 기입해주세요"
        sss_listInput_Price.frame = CGRect(x: 10, y: 50, width: screenWidth, height: 25)
        sss_listInput_Price.placeholder = "예상 가격을 기입해주세요"
        
        sss_listInput_hopePlace.frame = CGRect(x: 10, y: 50, width: screenWidth, height: 25)
        sss_listInput_hopePlace.placeholder = "거래 장소를 기입해주세요"
        sss_listInput_more.frame = CGRect(x: 10, y: 50, width: screenWidth, height: 25)
        sss_listInput_more.placeholder = "추가사항을 기입해주세요"
        
        addImage.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        addImage.center = CGPoint(x: self.scrollView.frame.width / 2.0 , y: self.scrollView.frame.height / 2.0)
        Image1.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        Image2.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
        Image3.frame = CGRect(x: 0, y: 300, width: 100, height: 100)
        
        
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
        
//        ss_listView_6.addSubview(sss_listButton)
        
        ss_listView_5.addSubview(addImage)
        ss_listView_5.addSubview(Image1)
        ss_listView_5.addSubview(Image2)
        ss_listView_5.addSubview(Image3)
        
        
        s_Scrollview_0.addSubview(ss_listView_5)
        
        s_Scrollview_1.addSubview(ss_listView_0)
        s_Scrollview_1.addSubview(ss_listView_1)
        s_Scrollview_1.addSubview(ss_listView_2)
        
        s_Scrollview_2.addSubview(ss_listView_3)
        s_Scrollview_2.addSubview(ss_listView_4)
        
 //       s_Scrollview_3.addSubview(ss_listView_6)
        
        
        scrollView.addSubview(s_Scrollview_0)
        scrollView.addSubview(s_Scrollview_1)
        scrollView.addSubview(s_Scrollview_2)
//        scrollView.addSubview(s_Scrollview_3)
        
        
        
        
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
        for i in 1...self.stepIndicatorView.numberOfSteps + 1  {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: 100))
            
            if i == 1 {
               label.text = "사진을 올려주세요"
                
                //함수화
                        }
            else if i==2 {
               label.text = "필수항목"
                
            }
            else if i==3{
              label.text = "선택항목"
                
            }
            else{
                //label.text = "Uploaded"
                button.setTitle("저장", for: .normal)
                button.backgroundColor = UIColor(hex: "#2ecc71")
                button.addTarget(self, action: #selector(isSavedButtonPressed), for: .touchUpInside)

            }

            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 35)
            label.textColor = UIColor(hex: "#2ecc71")
            label.center = CGPoint(x: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0), y: (self.scrollView.frame.height * 0.3))
            button.center = CGPoint(x: self.scrollView.frame.width / 2.0 * (CGFloat(4 - 1) * 2.0 + 1.0), y: self.scrollView.frame.height / 2.0)
                
            self.scrollView.addSubview(label)
            self.scrollView.addSubview(button)

        }
    }
    
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        stepIndicatorView.currentStep = Int(pageIndex)
    }
    
    @objc func imagePicker(){
        
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 3
        
        present(imagePickerController, animated: true, completion: nil)
    }
//    @objc func didDoneButtonPressed(){
//
//    }
    
    
    @objc func addPost()->String{
        
        print("print addPost")
        
        let key = refPost.childByAutoId().key
        var imageValue = [String:String]()
        
        for image in imageArray {
            let refImage = refPost.child(key).child("ImageUrl")
            let autoID = refImage.childByAutoId().key
            let childRefStorage = refStorage.child("postImages").child(autoID)
            let image = UIImageJPEGRepresentation(image, 0.8)
            
            childRefStorage.putData(image!, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("this is error: ",error!)
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
                            
                            print("this is imageUrl: ", imageUrl)
                            
                            
                            let post = ["id":key,
                                        "postProduct": self.sss_listInput_content.text! as String,
                                        "postPrice": self.sss_listInput_Price.text! as String,
                                        "postContent": self.sss_listInput_more.text! as String,
                                        "uid": self.uid!,
                                        "postMaxMan": self.sss_listInput_maxMan.text! as String,
                                        "postWishLocation": self.sss_listInput_hopePlace.text! as String
                            ]
                            imageValue[autoID] = imageUrl
                            
                            print("this is imageValue",imageValue)
                            
                            //adding the post inside the generated unique key
                            self.refPost.child(key).setValue(post)
                            refImage.setValue(imageValue)
                            
                            
                        }
                    }
                    )}
            }
            
            
        }
        return key
    }
    
}


