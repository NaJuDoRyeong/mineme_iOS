import CoreLocation

public class LocationManager : CLLocationManager {
    static public let shared = LocationManager()
    
    private override init() {
        super.init()
    }
    
    public func checkAuthorizationStatus() -> CLAuthorizationStatus {
        
        if #available(iOS 14.0, *) {
            return self.authorizationStatus
        }else{
            return CLLocationManager.authorizationStatus()
        }
    }
    
    public func locationPermission() -> Bool? {
        
        switch checkAuthorizationStatus() {
        case .notDetermined, .restricted:
            print("🔅 위치 정보 요청")
            requestWhenInUseAuthorization()
            return nil
        case .denied:
            print("❎ 위치 정보 거부")
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            print("✅ 위치 정보 동의")
            return true
        @unknown default:
            break
        }
        
        return nil
    }
}
