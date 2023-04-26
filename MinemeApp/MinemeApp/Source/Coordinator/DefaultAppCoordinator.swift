import UIKit
import Common
import RxSwift
import Onboarding
import Login

class DefaultAppCoordinator: AppCoordinator {
    var childCoordinators = [Coordinator]()
    var navigation: UINavigationController
    var window: UIWindow?
    
    init(window: UIWindow?){
        self.window = window
        self.navigation = UINavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        window?.rootViewController = navigation
        switch UserdefaultManager.startMode {
        case .onboarding:
            showOnboarding()
        case .oauth, .initUserInfo, .enterCode, .waitingConnection:
            showLogin()
        case .main:
            showMain()
        }
    }
    
    func showMain() {
        let tabBarCoordinator = DefaultTabBarCoordinator(navigation: navigation)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
    
    func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(navigation: navigation)
        onboardingCoordinator.delegate = self
        onboardingCoordinator.start()
        childCoordinators.append(onboardingCoordinator)
        
    }
    
    func showLogin(){
        let loginCoordinator = LoginCoordinator(navigation: navigation)
        loginCoordinator.delegate = self
        loginCoordinator.startWithstartMode()
        childCoordinators.append(loginCoordinator)
        
    }
    
}

extension DefaultAppCoordinator : OnboardingCoordinatorDelegate, LoginCoordinatorDelegate {
    
    func didReadOnboarding(coordinator: OnboardingCoordinator) {
        UserdefaultManager.startMode = .oauth
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        showLogin()
    }
    
    func didLogin(coordinator: LoginCoordinator) {
        UserdefaultManager.startMode = .main
        childCoordinators = childCoordinators.filter{ $0 !== coordinator}
        showMain()
    }
    
}


