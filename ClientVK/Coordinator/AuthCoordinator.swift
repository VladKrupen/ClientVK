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
        authViewController.viewModel?.completionHandler = { [weak self] in
            self?.flowCompletionHandler?()
        }
    }
}
