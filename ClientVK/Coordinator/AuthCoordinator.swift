//
//  AuthCoordinator.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

final class AuthCoordinator: CoordinatorProtocol {
    var flowCompletionHandler: (() -> Void)?
    var navigationController: UINavigationController
    
    private let userAuthorization: UserAuthorization
    
    init(navigationController: UINavigationController, userAuthorization: UserAuthorization) {
        self.navigationController = navigationController
        self.userAuthorization = userAuthorization
    }
    
    func start() {
        showAuthModule()
    }
    
    private func showAuthModule() {
        let authViewController = ModuleFactory.createAuthModule()
        navigationController.pushViewController(authViewController, animated: true)
        authViewController.viewModel.authorizationHandler = { authProvider, authURL in
            switch authProvider {
            case .vk:
                guard let authURL else { return }
                guard UIApplication.shared.canOpenURL(authURL) else { return }
                UIApplication.shared.open(authURL)
            }
        }
        authViewController.viewModel.displayErrorAlertHandler = { [weak authViewController] error in
            authViewController?.hideSpiner()
            authViewController?.presentErrorAlert(message: error.rawValue)
        }
        authViewController.viewModel.navigateTo = { [weak self, weak authViewController] in
            self?.userAuthorization.isUserAuthorized = true
            authViewController?.hideSpiner()
            self?.flowCompletionHandler?()
        }
    }
}
