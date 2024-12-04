//
//  AuthViewModel.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import Foundation
import Combine

protocol AuthViewModelProtocol: AnyObject {
    var authorizationHandler: ((AuthProvider, URL?) -> Void)? { get set }
    var displayErrorAlertHandler: ((CustomError) -> Void)? { get set }
    var navigateTo: (() -> Void)? { get set }
    func vkAuthButtonWasPressed()
    func retrieveTokens(url: URL?)
}

final class AuthViewModel: AuthViewModelProtocol {
    var authorizationHandler: ((AuthProvider, URL?) -> Void)?
    var displayErrorAlertHandler: ((CustomError) -> Void)?
    var navigateTo: (() -> Void)?
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    private let vkAuthManager: AuthenticationManager
    
    init(vkAuthManager: AuthenticationManager) {
        self.vkAuthManager = vkAuthManager
    }
}

//MARK: AuthViewModelProtocol
extension AuthViewModel {
    func vkAuthButtonWasPressed() {
        let authURL = vkAuthManager.getAuthorizationUrl()
        authorizationHandler?(.vk, authURL)
    }
    
    func retrieveTokens(url: URL?) {
        vkAuthManager.getTokens(url: url)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    self?.displayErrorAlertHandler?(error)
                }
            } receiveValue: { tokenResponse in
                print(tokenResponse.accessToken)
            }
            .store(in: &cancellables)
    }
}
