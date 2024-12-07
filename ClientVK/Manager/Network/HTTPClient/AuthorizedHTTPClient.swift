//
//  AuthorizedHTTPClient.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

final class AuthorizedHTTPClient: NetworkingHTTPClient {
    
    enum Error: LocalizedError {
        case invalidUserToken
    }
    
    private let httpClient: NetworkingHTTPClient
    private let keyChainManager: KeyChainManager
    
    init(httpClient: NetworkingHTTPClient, keyChainManager: KeyChainManager) {
        self.httpClient = httpClient
        self.keyChainManager = keyChainManager
    }
    
    func makeRequest(_ request: NetworkingRequest) async throws -> NetworkingHTTPClient.Result {
        try await makeAuthorizeRequest(request)
    }
    
    private func makeAuthorizeRequest(_ request: NetworkingRequest) async throws -> NetworkingHTTPClient.Result {
        var authorizedRequest = request
//        let userToken = try keyChainManager.getToken()
        let userToken: String? = "fdjfkdjfkldjfl"
        guard let userToken else {
            throw Error.invalidUserToken
        }
        if authorizedRequest.headers == nil {
            authorizedRequest.headers = [
                "Authorization": "Bearer \(userToken)"
            ]
        } else {
            authorizedRequest.headers!["Authorization"] = "Bearer \(userToken)"
        }
        return try await httpClient.makeRequest(authorizedRequest)
    }
}
