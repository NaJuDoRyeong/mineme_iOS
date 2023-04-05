
import UIKit

enum LoginImages : String{
    
    case highlighter = "highlighter"
    case inviteCode = "image-breads"
    case waitCode = "image-wait-bread"
    case initUserInfo = "login-information"
    case speechBubble = "speech-bubble"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.module, with: nil)
    }
}
