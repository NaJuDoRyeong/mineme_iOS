//
//  ProfileImage.swift
//  Home
//
//  Created by 김민령 on 2022/11/06.
//

import UIKit

class ProfileImageView : UIImageView {
    
    private var imageURL: String?
    
    init(url : String? = nil){
        super.init(frame: .zero)
        self.imageURL = url
        initAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initAttribute(){
        if imageURL == nil {
//            self.image = UIImage(named: imageURL!)
        }else{
            //TODO: url image로 수정하기
//            self.image = LoadImage(url : imageURL)
            self.image = UIImage(named: imageURL!)
        }
        self.frame.size = CGSize(width: 80, height: 80)
    }
    
}
