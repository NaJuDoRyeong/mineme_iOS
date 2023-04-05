//
//  AppleLoginButton.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import SnapKit

class AppleLoginButton: UIButton {

    
    init(){
        super.init(frame: .zero)
        initAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        self.backgroundColor = .black
        self.layer.cornerRadius = 24
        self.setTitle("Apple 계정으로 시작", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setImage(UIImage(systemName: "applelogo"), for: .normal)
        self.tintColor = .white
        
        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
    }
    
}
