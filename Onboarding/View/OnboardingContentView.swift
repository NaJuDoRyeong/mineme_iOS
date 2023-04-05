//
//  OnboardingContentView.swift
//  Onboarding
//
//  Created by 김민령 on 2022/12/06.
//

import UIKit
import SnapKit

class OnboardingContentView: UIView {

    var content : OnboardingData?
    private var title = UILabel()
    private var subTitle = UILabel()
    private var imageView = UIImageView()
    
    init() {
        print("init OnboardingContentView")
        super.init(frame: .zero)
        self.backgroundColor = .white
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(content: OnboardingData){
        self.content = content
        title.text = content.title
        subTitle.text = content.subTitle
        imageView.image = content.image
    }
    
    private func initAttribute(){
        title = {
            let label = UILabel()
            label.textColor = .black
            label.font = .boldSystemFont(ofSize: 24)
            label.numberOfLines = 2
            label.textAlignment = .center
            
            return label
        }()
        
        subTitle = {
            let label = UILabel()
            label.textColor = .gray
            label.font = .boldSystemFont(ofSize: 14)
            label.numberOfLines = 2
            label.textAlignment = .center
            
            return label
        }()
    }
    
    private func initAutolayout(){
        
        [title, subTitle, imageView].forEach {
            self.addSubview($0)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(12)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
    }
}
