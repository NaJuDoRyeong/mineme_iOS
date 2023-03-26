import Foundation

public class UserdefaultManager {
    
    @EnumUserDefault(key: "startMode", defaultValue: StartMode.onboarding)
    public static var startMode : StartMode
    
    @UserDefault(key: "jwt", defaultValue: nil)
    public static var jwt : String?
    
    @UserDefault(key: "code", defaultValue: nil)
    public static var code : String?
}

public enum StartMode : String {
    case onboarding
    case oauth
    case enterCode
    case waitingConnection
    case main
}
