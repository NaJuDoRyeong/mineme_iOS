
import Foundation

public protocol LoginCoordinatorDelegate : AnyObject {
    func didLogin(coordinator: LoginCoordinator)
}
