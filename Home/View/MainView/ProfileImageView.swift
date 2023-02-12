//
//  ProfileImage.swift
//  Home
//
//  Created by 김민령 on 2022/11/06.
//

import UIKit
import Kingfisher

class ProfileImageView : UIImageView {
    
//    private var imageURL: String?
    
    init(image : UIImage){
        super.init(frame: .zero)
        self.image = image
        initAttribute()
    }
    
    init(url : URL? = nil){
        super.init(frame: .zero)
        bind(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(url: URL?){
        self.kf.setImage(with: url, options: circle())
    }
    
    func initAttribute(){
        self.frame.size = CGSize(width: 80, height: 80)
//        self.circle()
    }
    
    func changeImage(image : UIImage){
        self.image = image.resize(width: 80, height: 80)
//        self.circle()
    }
    
    func circle() -> KingfisherOptionsInfo {
        let roundCorner = RoundCornerImageProcessor(cornerRadius: self.frame.height/2)
        let resizing = ResizingImageProcessor(referenceSize: CGSize(width: 80, height: 80))
        
        return [.processor(roundCorner), .processor(resizing)]
        
//        self.contentMode = .scaleAspectFill
//        self.layer.cornerRadius = self.frame.height/2
//        self.layer.cornerCurve = .circular
//        self.clipsToBounds = true
    }
    
}
