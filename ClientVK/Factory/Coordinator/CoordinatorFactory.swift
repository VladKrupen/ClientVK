//
//  CoordinatorFactory.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

final class CoordinatorFactory {
    static func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinatorProtocol {
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        return appCoordinator
    }
    
    static func createAuthCoordinator(navigationController: UINavigationController) -> CoordinatorProtocol {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        return authCoordinator
    }
}
