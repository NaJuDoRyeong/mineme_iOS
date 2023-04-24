import UIKit
import Common

public class OnboardingCoordinator : Coordinator{
    public var childCoordinators = [Coordinator]()
    public var navigation: UINavigationController
    
    public weak var delegate: OnboardingCoordinatorDelegate?
    
    public init(navigation : UINavigationController) {
        self.navigation = navigation
    }
    
    public func start() {
        navigation.setNavigationBarHidden(true, animated: false)
        let vc = OnboardingViewController()
        vc.delegate = self
        navigation.viewControllers = [vc]

    }
}

extension OnboardingCoordinator : OnboardingViewControllerDelegate {
    func readOnboarding() {
        delegate?.didReadOnboarding(coordinator: self)
    }
}
