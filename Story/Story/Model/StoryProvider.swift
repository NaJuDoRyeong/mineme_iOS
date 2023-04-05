
import Foundation
import Common
import Moya

enum StoryProvider {
    case postContents(postModel : PostDTO)
    case postPhotos(photos: [Data])
}

extension StoryProvider : CommonTargetType {

    var path: String {
        switch self {
        case .postContents:
            return "/api/v1/stories"
        case .postPhotos:
            return "/api/v1/stories/image"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postContents , .postPhotos:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postContents(let postModel):
            return .requestJSONEncodable(postModel)
        case .postPhotos(let photos):
            let formData = photos.map { MultipartFormData(provider: .data($0), name: "image") }
            return .uploadMultipart(formData)
        }
    }

    var headers: [String : String]? {
        return Authorization
    }
}


