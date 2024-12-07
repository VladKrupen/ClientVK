//
//  URLSessionHTTPClient.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

final class URLSessionHTTPClient: NetworkingHTTPClient {
    
    enum Error: LocalizedError {
        case invalidURL
        case invalidResponse
        case serverError(error: Swift.Error)
    }
    
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func makeRequest(_ request: NetworkingRequest) async throws -> NetworkingHTTPClient.Result {
        guard let urlRequest = request.makeURLRequest() else {
            throw Error.invalidURL
        }
        do {
            let (data, urlResponse) =  try await urlSession.data(for: urlRequest)
            if let httpResponse = urlResponse as? HTTPURLResponse {
                return (data, httpResponse)
            } else {
                throw Error.invalidResponse
            }
        } catch {
            throw Error.serverError(error: error)
        }
    }
}
