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
    
    private let appAuthorization: AppAuthorization
    private let tokenStorage: TokenStorage
    
    init(appAuthorization: AppAuthorization, tokenStorage: TokenStorage) {
        self.appAuthorization = appAuthorization
        self.tokenStorage = tokenStorage
        setupDelegate()
    }
    
    private func setupDelegate() {
        appAuthorization.delegate = self
    }
    
    private func saveTokens(vkToken: VKToken) {
        tokenStorage.saveVKToken(vkToken: vkToken)
            .receive(on: DispatchQueue.main)
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
        Task {
            do {
                let token = try await self.appAuthorization.requestAuthorization(type: .vk)
                self.saveTokens(vkToken: token as! VKToken)
            } catch {
                //TODO выводить ошибку
                print(error.localizedDescription)
            }
        }
    }
    
    func retrieveTokens(url: URL?) {
        guard let url else { return }
        appAuthorization.handleVKAuthorizeURL(url: url)
    }
}

extension AuthViewModel: AuthorizationClientDelegate {
    func vkAuthorizationSafariURL(url: URL?) {
        DispatchQueue.main.async { [weak self] in
            self?.authorizationHandler?(.vk, url)
        }
    }
}
