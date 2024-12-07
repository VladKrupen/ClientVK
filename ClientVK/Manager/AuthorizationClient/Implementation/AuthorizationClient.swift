//
//  AuthorizationClient.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

protocol AuthorizationClientDelegate: AnyObject {
    func vkAuthorizationSafariURL(url: URL?)
}

final class AuthorizationClient: AppAuthorization {
    
    weak var delegate: AuthorizationClientDelegate?
    private let vkAuthorizationClient: VKAuthorizationClient
    private var vkAuthorizationContinuation: CheckedContinuation<Token, Swift.Error>?
    
    init(vkAuthorizationClient: VKAuthorizationClient) {
        self.vkAuthorizationClient = vkAuthorizationClient
    }
    
    func requestAuthorization(type: AuthorizationType) async throws -> Token {
        switch type {
        case .vk:
            try await requestVKAuthorization()
        }
    }
    
    func handleVKAuthorizeURL(url: URL) {
        Task {
            do {
                let vkToken = try await vkAuthorizationClient.requestTokens(url: url)
                vkAuthorizationContinuation?.resume(returning: vkToken)
            } catch {
                vkAuthorizationContinuation?.resume(throwing: error)
            }
        }
    }
    
    private func requestVKAuthorization() async throws -> Token {
        let vkAuthorizationURL = vkAuthorizationClient.generateSafariAuthURL()
        delegate?.vkAuthorizationSafariURL(url: vkAuthorizationURL)
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.vkAuthorizationContinuation = continuation
        }
    }
}
