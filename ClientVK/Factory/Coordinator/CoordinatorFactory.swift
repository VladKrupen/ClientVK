//
//  CoordinatorFactory.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

final class CoordinatorFactory {
    static let userDefaultsManager = UserDefaultsManager()
    
    static func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinatorProtocol {
        let appCoordinator = AppCoordinator(navigationController: navigationController,
                                            userAuthorization: userDefaultsManager)
        return appCoordinator
    }
    
    static func createAuthCoordinator(navigationController: UINavigationController) -> CoordinatorProtocol {
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                              userAuthorization: userDefaultsManager)
        return authCoordinator
    }
    
    static func createNewsFeedCoordinator(navigationController: UINavigationController) -> CoordinatorProtocol {
        let newsFeedCoordinator = NewsFeedCoordinator(navigationController: navigationController)
        return newsFeedCoordinator
    }
}
