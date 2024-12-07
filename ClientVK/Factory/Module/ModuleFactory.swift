//
//  ModuleFactory.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import Foundation

final class ModuleFactory {
    static let urlSessionHTTPClient = URLSessionHTTPClient()
    static let vkAuthorizationClient = VKAuthorizationClient(networkingHTTPClient: urlSessionHTTPClient)
    static let authorizationClient = AuthorizationClient(vkAuthorizationClient: vkAuthorizationClient)
    static let keyChainManager = KeyChainManager()
    
    static func createAuthModule() -> AuthViewController {
        let authViewModel = AuthViewModel(appAuthorization: authorizationClient, tokenStorage: keyChainManager)
        let authViewController = AuthViewController(viewModel: authViewModel)
        return authViewController
    }
    
    static func createNewsFeedModule() -> NewsFeedViewController {
        let newsFeedViewModel = NewsFeedViewModel()
        let newsFeedViewController = NewsFeedViewController(viewModel: newsFeedViewModel)
        return newsFeedViewController
    }
    
    static func createPostDetailsModule() -> PostDetailsViewController {
        let postDetailsViewModel = PostDetailsViewModel()
        let postDetailsViewController = PostDetailsViewController(viewModel: postDetailsViewModel)
        return postDetailsViewController
    }
}
