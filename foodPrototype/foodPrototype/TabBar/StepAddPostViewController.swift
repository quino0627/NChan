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

class StepAddPostViewController: UIViewController,UIScrollViewDelegate , ImagePickerDelegate, UITextFieldDelegate{

    var imagePickerController : ImagePickerController!
    var uid = Auth.auth().currentUser?.uid
    var timestamp: Double!
    var imageArray : [UIImage] = []
    var users = Dictionary<String,Bool>()
    
    //defining firebase reference var
    var refPost: DatabaseReference!
    var refStorage: StorageReference!
    @IBAction func keyDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var stepIndicatorView:StepIndicatorView!
    @IBOutlet weak var scrollView:UIScrollView!
//    @IBOutlet weak var DoneButton: UIBarButtonItem!
    
    //deleting selected images
    @objc func deleteButtonPressed(sender: UIButton){
        print(sender)
  //      ImageAndButton.remove(at: sender.tag)
        print("deleted")
 //       print(sender.tag)
 //       self.dismiss(animated: true, completion: nil)
    }
    
    //화면안의 버튼 눌렀을때
    @objc func isSavedButtonPressed(sender: UIButton){
        print(sender.tag)
        
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
            
            let alert = UIAlertController(title: "안내", message: "필수 항목을 모두 기입해주세요", preferredStyle: UIAlertControllerStyle.alert)
            
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
    
    var sss_imageView = UIView() //delete button
    
    var addImage = UIButton()
    
    var ImageAndButton : Array<UIView> = []
    var Images: Array<UIImageView> = []
    var Buttons: Array<UIButton> = []
    
    var imageViewArray: [UIImage] = []
    
    var cameraImage = UIImage(named: "background__camera.png") //버튼이미지
    var cancelImage = UIImage(named: "cancel (1).png")
    
   // var button = UIButton() //save button
    var saveButton = UIButton()
    
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
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        return
    }
    
    
    //피커안에 있는거
    func doneButtonDidPress (_ imagePicker: ImagePickerController, images: [UIImage]) {
       
        // INIT IMAGE ARRAY
        Images = []
        
        for view in ss_listView_5.subviews {
            view.removeFromSuperview()
        }
        
        ss_listView_5.addSubview(addImage)
        
        for (index, image) in images.enumerated() {
            if index >= 4 {
                break
            }
            
            print(image)
            ImageAndButton.append(UIView())
            Images.append(UIImageView())
            Buttons.append(UIButton())
            
            Buttons[index].isEnabled = true
            
            Images[index].image = image
            
            Buttons[index].frame = CGRect(x: 100 * (index) + 10 * (index), y: 0, width: 20, height: 20)
            Images[index].frame = CGRect(x: 100 * (index) + 10 * (index), y: 0, width: 100, height: 100)
            
          //  ImageAndButton[index].frame = CGRect(x: 0, y: 100 * (index), width: 100, height: 100)
            
            Buttons[index].tag = index
            Buttons[index].setBackgroundImage(cancelImage, for: .normal)
            // Buttons[index].addTarget(self, action: #selector(isSavedButtonPressed), for: .touchUpInside) deleteButtonPressed
            Buttons[index].addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
            
            //ImageAndButton[index].addSubview(Images[index])
            //ImageAndButton[index].addSubview(Buttons[index])

            ss_listView_5.addSubview(Images[index])
            ss_listView_5.addSubview(Buttons[index])
            
            imageArray.append(image)
            
            print(Buttons[index].frame)
            //print(ImageAndButton[index].frame)
            print(Images[index].frame)
            
            print("good")
        }
        /*
        imageViewArray = imageArray
    
        for i in 0 ... ((imageArray.count - 1 >= 4) ? 3 : imageArray.count - 1) {
            Images.append(UIImageView())
            Images[i].image = imageViewArray[i]
            Images[i].frame = CGRect(x: 0, y: 100 * (i), width: 100, height: 100)
            ss_listView_5.addSubview(Images[i])
          //  print(imageViewArray[i])
            
            Button[i]
            
            print(i, imageArray.count)
        }
        */
       
        print("count:",(imageArray.count))
        
       // 채팅방 개서ㅕㄹ하는 부분
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    //키보드
/*    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        } else {
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }*/
    
    //키보드-2
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        addImage.setBackgroundImage(cameraImage, for: .normal) //초기 이미지
        
        addImage.isUserInteractionEnabled = true
        addImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
        
        //getting a reference to the node post
        refPost = Database.database().reference().child("posts");
        refStorage = Storage.storage().reference();
        
        //키보드
        sss_listInput_content.returnKeyType = .done
        sss_listInput_maxMan.returnKeyType = .done
        sss_listInput_Price.returnKeyType = .done
        sss_listInput_hopePlace.returnKeyType = .done
        sss_listInput_more.returnKeyType = .done

        sss_listInput_content.delegate = self
        sss_listInput_maxMan.delegate = self
        sss_listInput_Price.delegate = self
        sss_listInput_hopePlace.delegate = self
        sss_listInput_more.delegate = self
        
        sss_listInput_maxMan.keyboardType = UIKeyboardType.decimalPad
        sss_listInput_Price.keyboardType = UIKeyboardType.decimalPad
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        

    
        //Customization by coding:
        //self.stepIndicatorView.numberOfSteps = 5
        //self.stepIndicatorView.currentStep = 0
        self.stepIndicatorView.circleColor = UIColor(red: 82/255.0, green: 182/255.0, blue: 172/255.0, alpha: 0.7)
        self.stepIndicatorView.circleTintColor = UIColor(red: 82/255.0, green: 182/255.0, blue: 172/255.0, alpha: 1.0)
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
        
        addImage.frame = CGRect(x:0, y: 0, width: s_Scrollview_0.frame.width, height:s_Scrollview_0.frame.width)
        addImage.center = CGPoint(x: s_Scrollview_0.frame.width / 2.0 , y: s_Scrollview_0.frame.width / 2.0)
        
        saveButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        saveButton.tag = 1
        saveButton.setTitle("저장", for: .normal)
        saveButton.backgroundColor = UIColor(hex: "#2ecc71")
        saveButton.addTarget(self, action: #selector(isSavedButtonPressed), for: .touchUpInside)
        saveButton.center = CGPoint(x: s_Scrollview_0.frame.width / 2.0 , y: s_Scrollview_0.frame.width / 1.5)
 //       saveButton.layer.cornerRadius = saveButton.frame.height / 2
 //       saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 5.0

        
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
        
        ss_listView_5.addSubview(addImage)
        
        s_Scrollview_0.addSubview(ss_listView_5)
        
        s_Scrollview_1.addSubview(ss_listView_0)
        s_Scrollview_1.addSubview(ss_listView_1)
        s_Scrollview_1.addSubview(ss_listView_2)
        
        s_Scrollview_2.addSubview(ss_listView_3)
        s_Scrollview_2.addSubview(ss_listView_4)
        s_Scrollview_2.addSubview(saveButton) //
        
 //       s_Scrollview_3.addSubview(ss_listView_6)
        
        
        scrollView.addSubview(s_Scrollview_0)
        scrollView.addSubview(s_Scrollview_1)
        scrollView.addSubview(s_Scrollview_2)
//        scrollView.addSubview(s_Scrollview_3)
        
        
        
        
        s_Scrollview_1.contentSize = CGSize(width: screenWidth, height: screenHeight * 1.5)
       // s_Scrollview_2.contentSize = CGSize(width: screenWidth, height: screenHeight * 1.5)
        
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
          //  let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: 100))
            
            if i == 1 {
               //label.text = "사진을 올려주세요"
                
                //함수화
                        }
            else if i==2 {
               //label.text = "필수항목"
                
            }
            else if i==3{
             // label.text = "선택항목"
             //   label.text = "Uploaded"
             //   button.tag = 1
             //   button.setTitle("저장", for: .normal)
             //   button.backgroundColor = UIColor(hex: "#2ecc71")
             //   button.addTarget(self, action: #selector(isSavedButtonPressed), for: .touchUpInside)
            }
            else{


            }

           // label.textAlignment = NSTextAlignment.center
           // label.font = UIFont.systemFont(ofSize: 35)
           // label.textColor = UIColor(hex: "#2ecc71")
           // label.center = CGPoint(x: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0), y: (self.scrollView.frame.height * 0.3))
           // button.center = CGPoint(x: self.scrollView.frame.width / 2.0 * (CGFloat(3 - 1) * 2.0 + 1.0), y: self.scrollView.frame.height / 2.0)
                
            self.scrollView.addSubview(label)
            //self.scrollView.addSubview(button)

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
        imagePickerController.imageLimit = 4
        
        present(imagePickerController, animated: true, completion: nil)
    }
//    @objc func didDoneButtonPressed(){
//
//    }
    
    
    @objc func addPost()->String{
        
        print("print addPost")
        
        let key = refPost.childByAutoId().key
        var imageValue = [String:String]()
        
        for (index, image) in imageArray.enumerated() {
            //4개로 제한두는 부분
            if index == 4 {
             break
            }
            
            let refImage = refPost.child(key).child("ImageUrl")
            let autoID = refImage.childByAutoId().key
            let childRefStorage = refStorage.child("postImages").child(autoID)
            let image = UIImageJPEGRepresentation(image, 0.2)
            
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


