//
//  ProfileImage.swift
//  Home
//
//  Created by 김민령 on 2022/11/06.
//

import UIKit
import Kingfisher

class ProfileImageView : UIImageView {
    
    var size = CGSize(width: 80, height: 80)
    
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
        circle(url: url)
    }
    
    func initAttribute(){
        self.frame.size = size
    }
    
    func changeImage(image : UIImage){
        circle(image: image)
    }
    
    func circle(url : URL?) {
        let processor = ResizingImageProcessor(referenceSize: size) |> RoundCornerImageProcessor(cornerRadius: size.width/2)

        self.kf.setImage(with: url, options: [.processor(processor)])
    }
    
    func circle(image: UIImage) {
        self.image = image.resize(width: 80, height: 80)
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = self.frame.height/2
        self.layer.cornerCurve = .circular
        self.clipsToBounds = true
    }
    
    func changeSize(size: CGSize){
        self.size = size
    }
    
}
