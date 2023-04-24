import UIKit
import Common

public class StoryCoordinator: Coordinator{
    public var childCoordinators = [Coordinator]()
    public var navigation: UINavigationController
    
    public init(navigation : UINavigationController) {
        self.navigation = navigation
    }
    
    public func start() {
        navigation.setNavigationBarHidden(true, animated: false)
        let vc = StoryHomeViewController()
        navigation.viewControllers = [vc]
    }
}
