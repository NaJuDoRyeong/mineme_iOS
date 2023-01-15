//
//  PostPhotoView.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import UIKit
import CommonUI

class PostPhotoView: FeedUIView {

    let postButton = UIButton()
    let representButton = UIButton()
    
    init(image: UIImage? = nil){
        super.init()
        self.imageView.image = image
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        self.postButton.setImage(UIImage(named: "select-photo"), for: .normal)
        self.representButton.setImage(UIImage(named: "icon-check"), for: .normal)
        self.representButton.tintColor = .white
        self.representButton.isHidden = true
    }
    
    func initAutolayout(){
        
        [imageView, postButton, representButton].forEach { self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        postButton.snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }
        
        representButton.snp.makeConstraints {
            $0.top.equalTo(imageView).offset(8)
            $0.right.equalTo(imageView).offset(-11)
        }
    }
    
    func setImage(_ image: UIImage){
        self.imageView.image = image
        self.postButton.isHidden = true
        self.representButton.isHidden = false
        self.representButton.addTarget(self, action: #selector(selectRepresentImage), for: .touchUpInside)
    }

}

@objc
extension PostPhotoView {
    //TODO: select event 추가하기
    func selectRepresentImage(){
        if representButton.tintColor == .white {
            self.representButton.tintColor = .black
        }
        else {
            self.representButton.tintColor = .white
        }
        
    }
}
