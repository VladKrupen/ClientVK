//
//  AppCoordinator.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    var navigationController: UINavigationController
    private let userAuthorization: UserAuthorization
    private var childCoordinators: [CoordinatorProtocol] = .init()
    
    init(navigationController: UINavigationController, userAuthorization: UserAuthorization) {
        self.navigationController = navigationController
        self.userAuthorization = userAuthorization
    }
    
    func start() {
        if userAuthorization.isUserAuthorized {
            showNewsFeedFlow()
        } else {
            showAuthFlow()
        }
    }
    
    private func showAuthFlow() {
        let authCoordinator = CoordinatorFactory.createAuthCoordinator(navigationController: navigationController)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
        authCoordinator.flowCompletionHandler = { [weak self] in
            self?.childCoordinators.removeAll()
            self?.showNewsFeedFlow()
        }
    }
    
    private func showNewsFeedFlow() {
        let newsFeedCoordinator = CoordinatorFactory.createNewsFeedCoordinator(navigationController: navigationController)
        childCoordinators.append(newsFeedCoordinator)
        newsFeedCoordinator.start()
    }
}
