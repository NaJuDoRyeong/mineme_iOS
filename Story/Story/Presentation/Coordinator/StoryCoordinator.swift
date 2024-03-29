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
        vc.reactor = makeReactor()
        navigation.viewControllers = [vc]
    }
    
    private func makeReactor() -> StoryHomeViewReactor {
        let repository = DummyPostRepository()
        let useCase = DefaultGetPostUseCase(repository)
        return StoryHomeViewReactor(useCase: useCase)
    }
}
