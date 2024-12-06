//
//  VKAuthenticationManager.swift
//  ClientVK
//
//  Created by Vlad on 3.12.24.
//

import Foundation
import CryptoKit
import Combine

final class VKAuthenticationManager {
    private let authURLString: String = "https://id.vk.com/authorize"
    private let cliendId: String = "52791583"
    private let redirectUri: String = "vk52791583://vk.com/blank.html"
    private let state: String = "welcomeToClientVK"
    private var codeVerifier: String
    private var codeChallenge: String
    
    init() {
        self.codeVerifier = Self.generateCodeVerifier()
        self.codeChallenge = Self.createCodeChallenge(from: codeVerifier)
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
    
    private func exchangeCodeForTokens(code: String, deviceId: String) -> AnyPublisher<VKToken, CustomError> {
        return Future { [weak self] promise in
            guard let self else { return }
            guard let tokenURL = URL(string: "https://id.vk.com/oauth2/auth") else {
                promise(.failure(.invalidURL))
                return
            }
            var urlRequest = URLRequest(url: tokenURL)
            urlRequest.httpMethod = HTTPMethod.post
            let bodyParameters = "grant_type=authorization_code&redirect_uri=\(redirectUri)&client_id=\(cliendId)&device_id=\(deviceId)&state=\(state)&code_verifier=\(codeVerifier)&code=\(code)"
            urlRequest.httpBody = bodyParameters.data(using: .utf8)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil, let data = data else {
                    promise(.failure(.invalidResponse))
                    return
                }
                do {
                    let tokenResponse = try JSONDecoder().decode(VKToken.self, from: data)
                    promise(.success(tokenResponse))
                } catch {
                    promise(.failure(.somethingWentWrong))
                }
            }
            .resume()
        }
        .eraseToAnyPublisher()
    }
}

//MARK: AuthManager
extension VKAuthenticationManager: AuthenticationManager {
    func getAuthorizationUrl() -> URL? {
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
    
    func getTokens(url: URL?) -> AnyPublisher<VKToken, CustomError> {
        guard let url else {
            return Fail(error: CustomError.invalidURL)
                .eraseToAnyPublisher()
        }
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let state = urlComponents.queryItems?.first(where: { $0.name == OAuthParameter.state })?.value,
              let code = urlComponents.queryItems?.first(where: { $0.name == OAuthParameter.code })?.value,
              let deviceId = urlComponents.queryItems?.first(where: { $0.name == OAuthParameter.deviceId })?.value,
              state == self.state else {
            return Fail(error: CustomError.somethingWentWrong)
                .eraseToAnyPublisher()
        }
        return exchangeCodeForTokens(code: code, deviceId: deviceId)
    }
}
