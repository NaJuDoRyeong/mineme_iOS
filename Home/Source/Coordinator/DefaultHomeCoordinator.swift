import UIKit
import Common

public class DefaultHomeCoordinator: HomeCoordinator{
    
    public var childCoordinators = [Coordinator]()
    public var navigation: UINavigationController
    
    public init(navigation : UINavigationController) {
        self.navigation = navigation
    }
    
    public func start() {
        navigation.setNavigationBarHidden(true, animated: false)
        let vc = HomeViewController()
        navigation.viewControllers = [vc]
    }
    
    func showSettingFlow(){
        navigation.pushViewController(HomeSettingViewController(), animated: true)
    }
    
}
