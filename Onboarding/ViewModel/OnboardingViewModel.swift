import Foundation
import CoreLocation
import UserNotifications
import Common

class OnboardingViewModel : NSObject {
    
    func notificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                print("✅ notification 권한 허용")
            } else {
                print("❎ notification 권한 거부")
            }
        })
    }
}
