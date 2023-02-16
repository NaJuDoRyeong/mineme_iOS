//
//  InviteViewController.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import CommonUI

class InviteViewController: UIViewController {
    
    var largeLabel = UILabel()
    var image = UIImageView()
    var codeIs = UILabel()
    var code = UIButton()
    
    var nextButton = CommonButton(text: "다 음")

    var toast = ToastMessage(type: .info)

    override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initAutoLayout()

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
        
        image.image = UIImage(named: "icon-breads")
        
        codeIs = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .gray
            label.text = "내 코드는"
            return label
        }()
        
        code = {
            let btn = UIButton()
            btn.setBackgroundImage(UIImage(named: "highlighter"), for: .normal)
            //FIXME: title -> userdefaults에 저장한 코드로 변경
            btn.setTitle("DUMMY0427", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.addTarget(self, action: #selector(copyString), for: .touchUpInside)
            return btn
        }()
        
        
        toast.setText("클립보드에 복사되었습니다")
    }
    
    func initAutoLayout(){
        [largeLabel, image, codeIs, code, toast, nextButton].forEach {
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
    
}
