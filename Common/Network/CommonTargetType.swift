import Foundation
import Moya

enum TargetResource : String {
    case developURL
    case productURL
}

public protocol CommonTargetType : TargetType {
}

extension CommonTargetType {
    public var baseURL: URL {
        let url = ResourceManager.plistForKey(key: TargetResource.developURL.rawValue) as! String
        return URL(string: url)!
    }
    
    public var Authorization : [String : String]? {
        if let jwt = UserdefaultManager.jwt {
            return ["Authorization" : "Bearer \(jwt)"]
        } else {
            return nil
        }
    }
}
