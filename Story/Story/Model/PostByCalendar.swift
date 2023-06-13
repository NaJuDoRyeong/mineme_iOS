
import Foundation

struct PostByCalendar : Decodable {
    let year, month : String
    let posts : [PostPreview]
}
