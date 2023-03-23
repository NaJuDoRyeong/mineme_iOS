import Foundation

class ResourceManager {
    
    
    static func valueForKey(key: String) -> Any? {
        let bundle = Bundle(for: Self.self)
        
        guard let url = bundle.url(forResource: "Resource", withExtension: "plist") else {
            print("no url")
            
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("no data")
            return nil
        }
        
        guard let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) else {
            print("no plist")
            return nil
        }
        
        guard let value = plist as? [String: Any] else {
            print("no value")
            return nil
        }
        
        return value[key]
    }
    
}
