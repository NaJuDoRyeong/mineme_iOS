//
//  CommonPhotoPicker.swift
//  CommonUI
//
//  Created by 김민령 on 2022/11/09.
//

import UIKit

extension UIImage {
    public func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
}
