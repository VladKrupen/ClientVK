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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        authViewController.viewModel.displayErrorAlertHandler = { error in
            authViewController.presentErrorAlert(message: error.rawValue)
        }
        authViewController.viewModel.navigateTo = { [weak self] in
            self?.flowCompletionHandler?()
        }
    }
}
