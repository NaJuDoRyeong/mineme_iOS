
import UIKit

enum HomeImages : String {
    
    case line = "line"
    case noImage = "no-image-donut"
    case loverProfile = "profile-lover"
    case myProfile = "profile-my"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.module, with: nil)
    }

}
