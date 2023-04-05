
import UIKit

enum TabBarItemType : CaseIterable{
    case home, story, setting
    
    var tabBarItem : UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "", image: AppImages.homeTab.image , selectedImage: AppImages.selectedHomeTab.image)
        case .story:
            return UITabBarItem(title: "", image: AppImages.storyTab.image, selectedImage: AppImages.selectedStoryTab.image)
        case .setting:
            return UITabBarItem(title: "", image: AppImages.settingTab.image , selectedImage: AppImages.selectedSettingTab.image)
        }
    }
}
