//
//  InformationViewController.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import CommonUI
import SnapKit
import RxSwift

class LoginInformationViewController: UIViewController {
    
    let nameField = TextFieldWithTitle(title: "이름", textLimit: 6, placeholder: "이름 입력")
    let birthday = CustomDatePicker(title: "생년월일")
    let nextButton = CommonButton(text: "다 음")

    override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initAutolayout()
        bind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var disposeBag = DisposeBag()
    
    func bind(){
        birthday.observable.subscribe { _ in
            self.allFill()
        }.disposed(by: disposeBag)
    }
    
    
    func initAttribute(){
        self.view.backgroundColor = .white
        nameField.textField.addTarget(self, action: #selector(textFieldChange(textField:)), for: .editingChanged)
        
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        
        nextButton.deactivate()
    }
    
    func initAutolayout(){
        [nameField, birthday, nextButton].forEach {
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
        
    }
    

}

extension LoginInformationViewController {
    
    // MARK: - 빈공간 touch -> 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func allFill(){
        if let text = nameField.textField.text {
            if text != "" && birthday.allCheck {
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
        //FIXME: data binding
        let presenter = InviteViewController()
        presenter.modalPresentationStyle = .fullScreen
        present(presenter, animated: true)
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
