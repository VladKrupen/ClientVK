//
//  SceneDelegate.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let appCoordinator = CoordinatorFactory.createAppCoordinator(navigationController: UINavigationController())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = appCoordinator.navigationController
        appCoordinator.start()
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        self.window = window
    }
        
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let url = URLContexts.first?.url
        if let authViewController = getCurrentViewController() as? AuthViewController {
            authViewController.viewModel.retrieveTokens(url: url)
        }
    }
}

extension SceneDelegate {
    private func getCurrentViewController() -> UIViewController? {
        guard let rootViewController = window?.rootViewController else { return nil }
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }
        return rootViewController
    }
}

