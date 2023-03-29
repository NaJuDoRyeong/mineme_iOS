import UIKit

extension UIImage {
    public func downscaleTOjpegData(maxBytes: UInt) -> Data? {
        var quality = 1.0
        while quality > 0 {
            guard let jpeg = jpegData(compressionQuality: quality)
            else { return nil }
            if jpeg.count <= maxBytes {
                return jpeg
            }
            quality -= 0.1
        }
        return nil
    }
    
    public func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
}
