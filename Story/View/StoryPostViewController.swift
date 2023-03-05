//
//  SotryPostViewController.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import CommonUI
import UIKit
import SnapKit
import PhotosUI

class StoryPostViewController: UIViewController {

    let header = CommonHeader()
    let enterInforView : StoryPostEnterInfoView
    let writeContentView : StoryPostWriteContentView
    let storyPostVM = StoryPostViewModel(viewType: .enterInfo)
    let button = CommonButton(text: "사진고르기")
    
    init(){
        self.enterInforView = StoryPostEnterInfoView(vm: storyPostVM)
        self.writeContentView = StoryPostWriteContentView(vm: storyPostVM)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        print("StoryPostViewController viewDidLoad")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func initAttribute(){
        
        header.setTitle(string: "스토리 작성")
        header.leftIcon.setImage(UIImage(named: "btn-bottom"), for: .normal)
        header.leftIcon.transform = header.leftIcon.transform.rotated(by: .pi/2)
        header.leftIcon.addTarget(self, action: #selector(before), for: .touchUpInside)
        
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        writeContentView.photoBox.postButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        writeContentView.layer.opacity = 0
        writeContentView.isHidden = true
        
        
    }
    
    func initAutolayout(){

        [header, enterInforView, writeContentView,button].forEach {
            self.view.addSubview($0)
        }
        
        header.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        writeContentView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        enterInforView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-43)
            $0.centerX.equalToSuperview()
        }

    }
    
    deinit {
        print("StoryPostViewController deinit")
    }

}

extension StoryPostViewController {
    
    func showEnterInfo(){

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.writeContentView.layer.opacity = 0
        }completion: { [weak self] complete in
            if complete {
                self?.button.setText("사진고르기")
                self?.enterInforView.isHidden = false
                self?.writeContentView.isHidden = true
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.enterInforView.layer.opacity = 1
                }
            }
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
}

extension StoryPostViewController : UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요"
            textView.textColor = .lightGray
        }
        
    }
}

@objc
extension StoryPostViewController {
    
    func pickImage(){
        self.present(writeContentView.photoBox.picker, animated: true)
    }
    
    func before(){
        //if enterInformation -> dismiss
        switch storyPostVM.viewType {
        case .enterInfo:
            self.dismiss(animated: true)
        case .writeContent:
            showEnterInfo()
            storyPostVM.viewType = .enterInfo
        }
    }
    
    func tapButton(){
        //if enterInformation -> change view: writeContent
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.enterInforView.layer.opacity = 0
        }completion: { [weak self] complete in
            if complete {
                self?.button.setText("완료")
                self?.enterInforView.isHidden = true
                self?.writeContentView.isHidden = false
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.writeContentView.layer.opacity = 1
                }
            }
        }
        storyPostVM.viewType = .writeContent
    }
    
    func keyboardWillShow(_ noti : NSNotification) {
        if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = frame.cgRectValue
            let height = rect.height
            
            switch storyPostVM.viewType {
            case .enterInfo:
                button.transform = CGAffineTransform(translationX: 0, y: -(height-button.frame.height)-10)
            case .writeContent:
                self.view.transform = CGAffineTransform(translationX: 0, y: -height)
            }
        }
    }
    
    func keyboardWillHide(_ noti : NSNotification) {
        switch storyPostVM.viewType {
        case .enterInfo:
            button.transform = .identity
        case .writeContent:
            self.view.transform = .identity
        }
    }
}
