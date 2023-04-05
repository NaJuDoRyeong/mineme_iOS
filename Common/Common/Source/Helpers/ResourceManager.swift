import Foundation

public class ResourceManager {
    static func plistForKey(key: String) -> Any? {
        let bundle = Bundle.module
        
        guard let plistPath = bundle.path(forResource: "Resource", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: plistPath),
              let any = plistDict[key]
        else {
            fatalError("Unable to load Plist or get value from it.")
        }
        return any
    }
}
