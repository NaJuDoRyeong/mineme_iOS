//
//  PreviewFeedView.swift
//  CommonUI
//
//  Created by 김민령 on 2022/11/09.
//

import UIKit

open class CustomImageView: UIView {
    
    public var imageView = UIImageView()
    
    public enum Size : CGFloat {
        case big = 348
        case small = 166
    }
    
    public enum Shape {
        case round
        case rect
    }
    
    public var size : Size
    public var shape : Shape
    
    public init(_ size : Size = .big, _ shape : Shape = .round){
        self.size = size
        self.shape = shape
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.layer.cornerRadius = 16
        self.frame.size = CGSize(width: size.rawValue, height: size.rawValue)
        
        self.imageView.layer.cornerRadius = 16
        self.imageView.frame.size = CGSize(width: size.rawValue, height: size.rawValue)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
