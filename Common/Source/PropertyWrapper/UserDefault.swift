
import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key : String
    let value : T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.value = defaultValue
    }
    
    public var wrappedValue : T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? self.value }
        set { UserDefaults.standard.set(newValue, forKey: key)}
    }
}

@propertyWrapper
public struct EnumUserDefault<T> where T: RawRepresentable {
    let key: String
    let value: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.value = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            guard let rawValue = UserDefaults.standard.object(forKey: key) as? T.RawValue else {
                return value
            }
            return T(rawValue: rawValue) ?? value
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }
}

