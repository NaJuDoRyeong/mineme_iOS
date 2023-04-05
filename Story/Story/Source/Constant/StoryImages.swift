
import UIKit

enum StoryImages : String {
    case calendarButton = "calendar-change"
    case noStory = "no-image-bread"
    case storyButton = "story-change"
    case calendarCircle = "ugly-circle"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.module, with: nil)
    }
}
