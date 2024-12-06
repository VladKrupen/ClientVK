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
    
    private let authenticationManager: AuthenticationManager
    private let tokenStorage: TokenStorage
    
    init(authenticationManager: AuthenticationManager, tokenStorage: TokenStorage) {
        self.authenticationManager = authenticationManager
        self.tokenStorage = tokenStorage
    }
    
    private func saveTokens(vkToken: VKToken) {
        tokenStorage.saveTokens(vkToken: vkToken)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.navigateTo?()
                case .failure(let error):
                    self?.displayErrorAlertHandler?(error)
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}

//MARK: AuthViewModelProtocol
extension AuthViewModel {
    func vkAuthButtonWasPressed() {
        let authURL = authenticationManager.getAuthorizationUrl()
        authorizationHandler?(.vk, authURL)
    }
    
    func retrieveTokens(url: URL?) {
        authenticationManager.getTokens(url: url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    self?.displayErrorAlertHandler?(error)
                }
            } receiveValue: { [weak self] tokens in
                self?.saveTokens(vkToken: tokens)
            }
            .store(in: &cancellables)
    }
}
