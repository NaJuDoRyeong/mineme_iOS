
import UIKit

enum OnboardingImages : String{
    case onboarding1 = "onboarding-1"
    case onboarding2 = "onboarding-2"
    case onboarding3 = "onboarding-3"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.module, with: nil)
    }
    
    static func image(string: String) -> UIImage? {
        return UIImage(named: string, in: Bundle.module, with: nil)
    }
}
