//
//  AppCoordinator.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    var navigationController: UINavigationController
    private var childCoordinators: [CoordinatorProtocol] = .init()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAuthFlow()
    }
    
    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
        authCoordinator.flowCompletionHandler = { [weak self] in
            self?.childCoordinators.removeAll()
        }
    }
}
