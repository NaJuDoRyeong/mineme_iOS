//
//  HomeSettingViewController.swift
//  Home
//
//  Created by 김민령 on 2022/11/08.
//

import UIKit
import CommonUI

open class HomeSettingViewController: UIViewController {
    
    private var profileImage = ProfileImageView(url: "profile-my")
    private var editImageButton = UIButton()
    private var nameField = TextFieldWithTitle(title: "이름", placeholder: "이름 입력")
    private var coupleNameField = TextFieldWithTitle(title: "커플이름", placeholder: "이름 입력")
    private var loverCommnetField = TextFieldWithTitle(title: "상대 소개글", placeholder: "나의 소개글은 상대가 작성할 수 있어요!")
    private var instaIdField = TextFieldWithTitle(title: "링크", placeholder: "링크 입력")
    

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()

        // Do any additional setup after loading the view.
    }
    
    func initAttribute() {
        
        editImageButton.setImage(UIImage(named: "icon-camera"), for: .normal)
    }
    
    func initAutolayout() {
        
        [profileImage, editImageButton, nameField, coupleNameField, loverCommnetField, instaIdField].forEach { self.view.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(133)
            $0.centerX.equalToSuperview()
        }
        
        editImageButton.snp.makeConstraints {
            $0.top.equalTo(profileImage).offset(56)
            $0.left.equalTo(profileImage).offset(54)
        }
        
        nameField.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(52)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        coupleNameField.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        loverCommnetField.snp.makeConstraints {
            $0.top.equalTo(coupleNameField.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        instaIdField.snp.makeConstraints {
            $0.top.equalTo(loverCommnetField.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
    }

}

extension HomeSettingViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
