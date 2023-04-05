
import UIKit

public protocol Coordinator : AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigation: UINavigationController { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    public func finish() {
        childCoordinators.removeAll()
        navigation.viewControllers.removeAll()
    }
}
