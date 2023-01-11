//
//  PostPhotoView.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import UIKit
import CommonUI

class PostPhotoView: FeedUIView {

    private var postButton : UIButton?
    
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
        if let _ = self.imageView.image {
            self.imageView.contentMode = .scaleAspectFill
        }
        else{
            self.imageView.image = UIImage(named: "select-photo")
        }
    }
    
    func initAutolayout(){
        
        [imageView].forEach { self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        
    }

}
