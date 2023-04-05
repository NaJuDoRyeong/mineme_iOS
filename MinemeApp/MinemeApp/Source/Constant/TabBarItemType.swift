
import UIKit

enum TabBarItemType : CaseIterable{
    case home, story, setting
    
    var tabBarItem : UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "", image: AppAssets.homeTab , selectedImage: AppAssets.selectedHomeTab)
        case .story:
            return UITabBarItem(title: "", image: AppAssets.storyTab, selectedImage: AppAssets.selectedStoryTab)
        case .setting:
            return UITabBarItem(title: "", image: AppAssets.settingTab , selectedImage: AppAssets.selectedSettingTab)
        }
    }
}
