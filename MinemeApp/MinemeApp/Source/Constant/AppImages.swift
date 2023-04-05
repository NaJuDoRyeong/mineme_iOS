
import UIKit

enum AppImages : String{
    case appIcon = "AppIcon"
    case appTitle = "AppTitle"
    case homeTab = "default-home"
    case selectedHomeTab = "selected-home"
    case storyTab = "default-story"
    case selectedStoryTab = "selected-story"
    case settingTab = "default-setting"
    case selectedSettingTab = "selected-setting"
    
    var image : UIImage? {
        return UIImage(named: self.rawValue)
    }
}
