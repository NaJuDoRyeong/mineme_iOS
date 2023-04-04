import UIKit
import Common

public class LoginCoordinator : Coordinator{
    public var childCoordinators = [Coordinator]()
    public var navigation: UINavigationController
    
    public weak var delegate: LoginCoordinatorDelegate?
    
    public init(navigation : UINavigationController) {
        self.navigation = navigation
    }
    
    public func start() {
        navigation.setNavigationBarHidden(true, animated: false)
        let vc = LoginViewController()
        vc.delegate = self
        navigation.viewControllers = [vc]
    }
    
    public func startWithstartMode(){
        switch UserdefaultManager.startMode {
        case .oauth:
            let vc = LoginViewController()
            vc.delegate = self
            navigation.viewControllers = [vc]
        case .initUserInfo:
            let vc = LoginInformationViewController()
            vc.delegate = self
            navigation.viewControllers = [vc]
        case .enterCode, .waitingConnection:
            let vc = InviteViewController()
            vc.delegate = self
            navigation.viewControllers = [vc]
        default:
            break
        }
    }
}

extension LoginCoordinator : LoginViewControllerDelegate {
    func nextProcess() {
        switch UserdefaultManager.startMode {
        case .oauth:
            let vc = LoginInformationViewController()
            vc.delegate = self
            navigation.pushViewController(vc, animated: true)
            UserdefaultManager.startMode = .initUserInfo
        case .initUserInfo:
            let vc = InviteViewController()
            vc.delegate = self
            navigation.pushViewController(vc, animated: true)
            UserdefaultManager.startMode = .enterCode
        case .waitingConnection:
            login()
        default:
            break
        }
    }
    
    func login() {
        delegate?.didLogin(coordinator: self)
    }
    
}


