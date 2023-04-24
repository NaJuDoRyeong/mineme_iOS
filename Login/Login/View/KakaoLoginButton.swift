//
//  KakaoLoginButton.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import SnapKit

class KakaoLoginButton: UIButton {

    init(){
        super.init(frame: .zero)
        initAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        self.backgroundColor = UIColor(red: 1, green: 0.899, blue: 0.371, alpha: 1)
        self.layer.cornerRadius = 24
        self.setTitle("카카오 계정으로 시작", for: .normal)
        self.setTitleColor(.black, for: .normal)
        
        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    

}
