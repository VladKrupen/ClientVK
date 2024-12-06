//
//  ModuleFactory.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import Foundation

final class ModuleFactory {
    static let vkAuthManager = VKAuthenticationManager()
    static let keyChainManager = KeyChainManager()
    
    static func createAuthModule() -> AuthViewController {
        let authViewModel = AuthViewModel(authenticationManager: vkAuthManager,
                                          tokenStorage: keyChainManager)
        let authViewController = AuthViewController(viewModel: authViewModel)
        return authViewController
    }
    
    static func createNewsFeedModule() -> NewsFeedViewController {
        let newsFeedViewModel = NewsFeedViewModel()
        let newsFeedViewController = NewsFeedViewController(viewModel: newsFeedViewModel)
        return newsFeedViewController
    }
}
