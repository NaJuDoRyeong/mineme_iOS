
import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key : String
    let value : T
    
    public init(key: String, value: T) {
        self.key = key
        self.value = value
    }
    
    public var wrappedValue : T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? self.value }
        set { UserDefaults.standard.set(newValue, forKey: key)}
    }
}
