//
//  HomeProfileView.swift
//  Home
//
//  Created by 김민령 on 2022/11/06.
//

import UIKit
import SnapKit
import Common

class HomeProfileView: UIView {
    
    private lazy var imageView = ProfileImageView()
    private lazy var nameLabel = UILabel()
    private lazy var commentLabel = UILabel()
    private lazy var instaIdLabel = UILabel()
    
    init(){
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: Profile){
        
        imageView.bind(url: data.image)
        
        nameLabel.text = data.name
        
        //Optional
        if let comment = data.comment {
            commentLabel.text = comment
        }
        
        instaIdLabel.text = data.atInstaId()
        
    }
    
    func initAttribute(){
        
        imageView.changeImage(image: CommonAssets.defaultProfile)
        
        nameLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18)
            return label
        }()
        
        commentLabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center

            label.numberOfLines = 3
            return label
        }()
        
        instaIdLabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 12)
            
            return label
        }()
        
    }
    
    func initAutolayout(){
        [imageView, nameLabel, commentLabel, instaIdLabel].forEach { self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            
        }
        
        instaIdLabel.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

    }
}
