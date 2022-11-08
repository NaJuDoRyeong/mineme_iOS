//
//  FeedPriview.swift
//  Home
//
//  Created by 김민령 on 2022/11/09.
//

import UIKit
import CommonUI

class FeedPriview: FeedUIView {
    
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
            self.imageView.image = UIImage(named: "no-image")
        }
    }
    
    func initAutolayout(){
        
        [imageView].forEach { self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
}
