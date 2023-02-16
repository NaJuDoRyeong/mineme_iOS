//
//  InformationViewController.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import CommonUI
import SnapKit

class LoginInformationViewController: UIViewController {
    
    let nameField = TextFieldWithTitle(title: "이름", textLimit: 6, placeholder: "이름 입력")
    let birthday = CustomDatePicker(title: "생년월일")
    let nextButton = CommonButton(text: "다 음")

    override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initAutolayout()
        
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

extension CommonButton {
    
    func activate(){
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor(named: "butter")
        self.isEnabled = true
    }
    
    func deactivate(){
        self.layer.borderWidth = 1.5
        self.layer.borderColor = .init(gray: 0.5, alpha: 1)
        self.backgroundColor = .clear
        self.isEnabled = false
    }
}

extension LoginInformationViewController {
    
    
    // MARK: - 빈공간 touch -> 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        guard let text = textField.text else {
            return
        }
        if text == "" { nextButton.deactivate() }
        else { nextButton.activate() }
    }
    
    func keyboardWillShow(_ noti : NSNotification) {
        if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = frame.cgRectValue
            let height = rect.height
            
            nextButton.transform = CGAffineTransform(translationX: 0, y: -(height-43))
            
        }
    }
    
    func keyboardWillHide(_ noti : NSNotification) {
        nextButton.transform = .identity
    }
    
}
