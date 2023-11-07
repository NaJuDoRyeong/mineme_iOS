

import Foundation
import RxSwift

protocol PostByCalendarRepository {
    func fetchPost(year: Int, month: Int) -> Observable<PostByCalendar>
}
