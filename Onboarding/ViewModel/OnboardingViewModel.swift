import Foundation
import CoreLocation
import UserNotifications
import Common

class OnboardingViewModel : NSObject {
    
    var contents = [OnboardingData]()
    
    override init(){
        super.init()
        addContents()
    }
    
    func addContents(){
        contents.append(OnboardingData(title: "우리의 추억을 소중하고 이쁘게 보관해요", subTitle: "마인미에서 갤러리에 퍼져있는 우리의 사진을 위치별로 기록해요.", image: OnboardingAssets.onboarding1))
        
        contents.append(OnboardingData(title: "둘만의 소식을 빠르게 전해줄게요", subTitle: "기념일이나 피드 올라온걸 몰라서 곤란하지 않게 마인미가 알려줄게요!", image: OnboardingAssets.onboarding2))
        
        contents.append(OnboardingData(title: "사랑스러운 사진으로 하루하루 기억해봐요", subTitle: "캘린더를 우리의 사진으로 꾸며서 한 달을 추억으로 가득채워요.", image: OnboardingAssets.onboarding3))
    }
    
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
