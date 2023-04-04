
import UIKit

enum TabBarItemType : CaseIterable{
    case home, story, setting
    
    var tabBarItem : UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "", image: UIImage(named: "default-home"), selectedImage: UIImage(named: "selected-home"))
        case .story:
            return UITabBarItem(title: "", image: UIImage(named: "default-story"), selectedImage: UIImage(named: "selected-story"))
        case .setting:
            return UITabBarItem(title: "", image: UIImage(named: "default-story"), selectedImage: UIImage(named: "selected-story"))
        }
    }
}
