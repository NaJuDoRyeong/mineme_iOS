//
//  InformationViewController.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import SnapKit
import RxSwift
import Common

final public class LoginInformationViewController: UIViewController {
    
    let viewModel = LoginInformationViewModel()
    
    let nameField = TextFieldWithTitle(title: "이름", textLimit: 6, placeholder: "이름 입력")
    let birthday = CustomDatePicker(title: "생년월일")
    let imageView = UIImageView()
    let nextButton = CommonButton(text: "다 음")

    public override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initAutolayout()
        bind()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var disposeBag = DisposeBag()
    
    func bind(){
        birthday.allCheck.subscribe { [unowned self] check in
            print("check : \(check)")
            if check {
                self.allFill()
            }
            else {
                self.nextButton.deactivate()
            }
        }.disposed(by: disposeBag)
        
        viewModel.startMode.subscribe { [weak self] startMode in
            if startMode == .enterCode{
                self?.dismiss(animated: true)
            }
        }.disposed(by: disposeBag)
        
    }
    
    
    func initAttribute(){
        self.view.backgroundColor = .white
        nameField.textField.addTarget(self, action: #selector(textFieldChange(textField:)), for: .editingChanged)
        
        imageView.image = UIImage(named: "login-information")
        
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        
        nextButton.deactivate()
    }
    
    func initAutolayout(){
        [nameField, birthday, imageView, nextButton].forEach {
            self.view.addSubview($0)
        }
        
        nameField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(135)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        birthday.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(22)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)

        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(additionalSafeAreaInsets.bottom).offset(-43)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-192)
        }
        
    }
    
    deinit {
        nextButton.transform = .identity
    }
    

}

extension LoginInformationViewController {
    
    // MARK: - 빈공간 touch -> 키보드 내림
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func allFill(){
        if let text = nameField.textField.text {
            if text != "" && birthday.allCheck.value {
                nextButton.activate()
                return
            }
        }
        nextButton.deactivate()
    }
    
}

@objc
extension LoginInformationViewController {
    
    func tapNextButton(){
        viewModel.setUserInfo(name: nameField.textField.text, birthday: birthday.getDate())
    }
    
    func textFieldChange(textField: UITextField) {
        if let text = textField.text {
            //띄어쓰기 입력 금지
            if text.last == " " {
                textField.text?.removeLast()
            }
            if text == " " {
                return
            }
        }
        allFill()
    }
    
    func keyboardWillShow(_ noti : NSNotification) {
        if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = frame.cgRectValue
            let height = rect.height
            
            nextButton.transform = CGAffineTransform(translationX: 0, y: -(height-nextButton.frame.height)-10)
            
        }
    }
    
    func keyboardWillHide(_ noti : NSNotification) {
        nextButton.transform = .identity
    }
    
}
