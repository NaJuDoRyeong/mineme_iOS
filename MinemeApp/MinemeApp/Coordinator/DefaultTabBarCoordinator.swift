import UIKit
import Common
import Home
import Story
import Setting

class DefaultTabBarCoordinator: TabBarCoordinator {
    
    var childCoordinators = [Coordinator]()
    var navigation: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigation : UINavigationController){
        self.navigation = navigation
        self.tabBarController = TabBarController()
    }
    
    func start() {
        TabBarItemType.allCases.forEach { type in
            createNavigationController(type: type)
        }
        
        navigation.pushViewController(tabBarController, animated: false)
    }

    func createNavigationController(type: TabBarItemType) {
        let navigationController = UINavigationController()
        switch type {
        case .home:
            let coordinator = DefaultHomeCoordinator(navigation: navigationController)
            coordinator.navigation.tabBarItem = createTabBarItem(type: type)
            childCoordinators.append(coordinator)
            coordinator.start()
        case .story:
            let coordinator = StoryCoordinator(navigation: navigationController)
            coordinator.navigation.tabBarItem = createTabBarItem(type: type)
            childCoordinators.append(coordinator)
            coordinator.start()
        case .setting:
            let coordinator = SettingCoordinator(navigation: navigationController)
            coordinator.navigation.tabBarItem = createTabBarItem(type: type)
            childCoordinators.append(coordinator)
            coordinator.start()
        }
        
        if let _ = tabBarController.viewControllers {
            tabBarController.viewControllers?.append(navigationController)
        }
        else{
            tabBarController.viewControllers = [navigationController]
        }
    }
    
    func createTabBarItem(type: TabBarItemType) -> UITabBarItem {
        return type.tabBarItem
    }
    
}
