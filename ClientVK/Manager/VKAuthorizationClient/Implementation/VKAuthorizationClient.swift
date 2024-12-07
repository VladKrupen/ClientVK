//
//  VKAuthorizationClient.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation
import CryptoKit

final class VKAuthorizationClient {
    
    enum Error: LocalizedError {
        case invalidURL
        case parseURLError
    }
    
    private let authURLString: String = "https://id.vk.com/authorize"
    private let cliendId: String = "52791583"
    private let redirectUri: String = "vk52791583://vk.com/blank.html"
    private let state: String = "welcomeToClientVK"
    private var codeVerifier: String
    private var codeChallenge: String
    
    private let networkingHTTPClient: NetworkingHTTPClient
    
    init(networkingHTTPClient: NetworkingHTTPClient) {
        self.codeVerifier = Self.generateCodeVerifier()
        self.codeChallenge = Self.createCodeChallenge(from: codeVerifier)
        self.networkingHTTPClient = networkingHTTPClient
    }
    
    static private func generateCodeVerifier() -> String {
        let characters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        var codeVerifier = ""
        for _ in 0..<43 {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            codeVerifier.append(characters[randomIndex])
        }
        return codeVerifier
    }
    
    static private func createCodeChallenge(from verifier: String) -> String {
        let data = verifier.data(using: .utf8)!
        let hash = SHA256.hash(data: data)
        return Data(hash).base64EncodedString()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

//MARK: VKAuthorization
extension VKAuthorizationClient: VKAuthorization {
    func generateSafariAuthURL() -> URL? {
        var urlComponents = URLComponents(string: authURLString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "code_challenge", value: codeChallenge),
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "client_id", value: cliendId),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
            URLQueryItem(name: "prompt", value: "login"),
            URLQueryItem(name: "scope", value: "phone email")
        ]
        return urlComponents?.url
    }
    
    func requestTokens(url: URL?) async throws -> VKToken {
        guard let url else {
            throw Error.invalidURL
        }
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let state = urlComponents.queryItems?.first(where: { $0.name == OAuthParameter.state })?.value,
              let code = urlComponents.queryItems?.first(where: { $0.name == OAuthParameter.code })?.value,
              let deviceId = urlComponents.queryItems?.first(where: { $0.name == OAuthParameter.deviceId })?.value,
              state == self.state else {
            throw Error.parseURLError
        }
        let postRequest = NetworkingPostRequest(urlString: "https://id.vk.com/oauth2/auth")
        let bodyDictionary = [
            "code": code,
            "code_verifier": codeVerifier,
            "client_id": cliendId,
            "grant_type": "authorization_code",
            "redirect_uri": redirectUri,
            "state": state,
            "device_id": deviceId
        ]
        let body = try JSONSerialization.data(withJSONObject: bodyDictionary)
        postRequest.body = body
        do {
            let result = try await networkingHTTPClient.makeRequest(postRequest)
            let error = ResponseErrorDecoder().decode(response: result.response, data: result.data)
            guard error == nil else {
                throw error!
            }
            let vkToken = try JSONDecoder().decode(VKToken.self, from: result.data)
            return vkToken
        } catch {
            throw error
        }
    }
}
