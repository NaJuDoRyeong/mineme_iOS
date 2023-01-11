//
//  SotryPostViewController.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import CommonUI
import UIKit
import SnapKit

open class StoryPostViewController: UIViewController {
    
    private var datePicker = StoryDatePicker()
    private var photoBox = FeedUIView()
    private var textField = UITextField()
//    private var location = LocationSelector()
    

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        // Do any additional setup after loading the view.
    }
    
    func initAttribute(){
        
        photoBox.imageView.image = UIImage(named: "select-photo")
        photoBox.contentMode = .scaleAspectFill
        
        textField = {
          let tf = UITextField()
            tf.frame.size.height = 151
            tf.placeholder = "내용을 입력하세요"
            tf.layer.borderWidth = 1
            tf.layer.cornerRadius = 10
            tf.layer.borderColor = UIColor.lightGray.cgColor
            tf.font = UIFont.systemFont(ofSize: 14)
            
            return tf
        }()
    
        
    }
    
    func initAutolayout(){
        [photoBox, datePicker, textField].forEach {
            self.view.addSubview($0)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalToSuperview().offset(121)
            $0.left.equalToSuperview().offset(27)
        }
        
        photoBox.snp.makeConstraints {
            $0.top.equalToSuperview().offset(156)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(photoBox.size.rawValue)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(photoBox.snp.bottom).offset(12)
            $0.left.equalTo(photoBox)
            $0.right.equalTo(photoBox)
            $0.height.equalTo(151)
        }
        

    }
    

}
