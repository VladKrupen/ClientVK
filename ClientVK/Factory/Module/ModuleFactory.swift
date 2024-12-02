//
//  ModuleFactory.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import Foundation

final class ModuleFactory {
    static func createAuthModule() -> AuthViewController {
        let authViewController = AuthViewController()
        let authViewModel = AuthViewModel()
        authViewController.viewModel = authViewModel
        return authViewController
    }
}
