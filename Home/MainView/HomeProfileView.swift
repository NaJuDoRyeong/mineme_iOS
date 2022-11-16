//
//  HomeProfileView.swift
//  Home
//
//  Created by 김민령 on 2022/11/06.
//

import UIKit
import SnapKit

class HomeProfileView: UIView {
    
    private var imageView = ProfileImageView()
    private var nameLabel = UILabel()
    private var commentLabel = UILabel()
    private var instaIdLabel = UILabel()
    
    private let data : Profile
    
    init(_ data: Profile){
        self.data = data
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initAttribute(){
        imageView = ProfileImageView(url: data.image)
        
        nameLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18)
            label.text = data.name
            return label
        }()
        
        //Optional
        if let comment = data.comment {
            commentLabel = {
                let label = UILabel()
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 12)
                label.text = comment
                label.numberOfLines = 3
                return label
            }()
        }
        
        //Optional
        if let instaId = data.instaId {
            instaIdLabel = {
                let label = UILabel()
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 12)
                label.text = instaId
                return label
            }()
        }
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
