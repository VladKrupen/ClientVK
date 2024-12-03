//
//  NewsFeedCoordinator.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

final class NewsFeedCoordinator: CoordinatorProtocol {
    var flowCompletionHandler: (() -> Void)?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showNewsFeedModule()
    }
    
    private func showNewsFeedModule() {
        let newsFeedViewController = ModuleFactory.createNewsFeedModule()
        navigationController.setViewControllers([newsFeedViewController], animated: true)
    }
}
