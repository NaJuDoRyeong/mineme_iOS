//
//  InviteViewController.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import Common

public class InviteViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    var largeLabel = UILabel()
    var image = UIImageView()
    var codeIs = UILabel()
    var code = UIButton()
    var bubble = UIImageView()
    
    var codeField = TextFieldWithTitle(title: "상대방의 코드를 입력해주세요")
    var nextButton = CommonButton(text: "다 음")

    var toast = ToastMessage()
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initAutoLayout()

    }
    
    public override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func initAttribute(){
        
        self.view.backgroundColor = .white
        
        largeLabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = .black
            label.numberOfLines = 0
            label.text = "상대방의 코드를 적어주세요!"
            
            return label
        }()
        
        image.image = LoginAssets.inviteCode
        
        codeIs = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .gray
            label.text = "내 코드는"
            return label
        }()
        
        code = {
            let btn = UIButton()
            btn.setBackgroundImage(LoginAssets.highlighter, for: .normal)
            //FIXME: title -> userdefaults에 저장한 코드로 변경
            btn.setTitle("DUMMY0427", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.addTarget(self, action: #selector(copyString), for: .touchUpInside)
            return btn
        }()
        
        bubble.image = LoginAssets.speechBubble
        
        codeField.textField.placeholder = "이름 입력"
        codeField.textField.addTarget(self, action: #selector(textFieldChange(textField:)), for: .editingChanged)
        
        nextButton.deactivate()
        nextButton.addTarget(self, action: #selector(enterLoverCode), for: .touchUpInside)
        
        toast.typeSetting(.success(text: "클립보드에 복사되었습니다"))
    }
    
    func initAutoLayout(){
        [largeLabel, image, codeIs, code, toast, nextButton, codeField, bubble].forEach {
            self.view.addSubview($0)
        }
        
        image.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-27)
            $0.top.equalToSuperview().offset(142)
            $0.width.equalTo(133).priority(.high)
        }
        
        largeLabel.snp.makeConstraints {
            $0.right.equalTo(image.snp.left).offset(-16)
            $0.left.equalToSuperview().offset(27)
            $0.top.equalTo(image)
        }
        
        codeIs.snp.makeConstraints {
            $0.top.equalTo(largeLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(27)
        }
        
        code.snp.makeConstraints {
            $0.top.equalTo(codeIs)
            $0.left.equalTo(codeIs.snp.right).offset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(additionalSafeAreaInsets).offset(-43)
        }
        
        codeField.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-44)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        bubble.snp.makeConstraints {
            $0.top.equalTo(code.snp.bottom).offset(3)
            $0.centerX.equalTo(code).offset(20)
        }
        
        toast.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-250)
            $0.centerX.equalToSuperview()
        }
        
        
    }
    

}

@objc
extension InviteViewController {
    
    func copyString(){
        //FIXME: userdefaults에 저장한 코드로 변경
        UIPasteboard.general.string = code.currentTitle
        toast.toast()
    }
    
    func enterLoverCode(){
        print(codeField.textField.text ?? "no code")
        //FIXME: network check
        UserdefaultManager.startMode = .waitingConnection
        delegate?.nextProcess()
    }
    
    func textFieldChange(textField: UITextField) {
        if let text = textField.text {
            //띄어쓰기 입력 금지
            if text.last == " " {
                textField.text?.removeLast()
            }
            if text == " " {
                nextButton.deactivate()
            }
            else{
                nextButton.activate()
            }
        }
    }
    
    func keyboardWillShow(_ noti : NSNotification) {
        if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = frame.cgRectValue
            let height = rect.height //키보드 높이구하기
            
            self.view.transform = CGAffineTransform(translationX: 0, y: -(height-nextButton.frame.height)-10)
            
        }
    }

    func keyboardWillHide(_ noti : NSNotification) {
        self.view.transform = .identity //원래 자리로 돌아가기
    }
    
}

extension InviteViewController {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
