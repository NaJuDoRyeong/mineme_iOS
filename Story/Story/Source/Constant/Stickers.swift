
import UIKit

struct Stickers{
    static let count = 9
    
    static var stickers : [UIImage] {
        var result = [UIImage]()
        for i in 1...count {
            result.append(UIImage(named: "sticker\(i)", in: Bundle.module, with: nil)!)
        }
        return result
    }
    
    static func sticker(_ num : Int) -> UIImage? {
        return UIImage(named: "sticker\(num)", in: Bundle.module, with: nil)
    }
    
}
