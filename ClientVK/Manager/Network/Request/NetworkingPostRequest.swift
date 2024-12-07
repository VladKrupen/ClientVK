//
//  NetworkingPostRequest.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

final class NetworkingPostRequest: NetworkingRequest {
    var body: Data?
    var queryParams: [String: String]?
    var headers: [String: String]?
    
    private let urlString: String
    private let timeoutSec: TimeInterval
    
    init(urlString: String, timeoutSec: TimeInterval = 30) {
        self.urlString = urlString
        self.timeoutSec = timeoutSec
    }
    
    public func makeURLRequest() -> URLRequest? {
        guard var url = URL(string: urlString) else {
            return nil
        }
        queryParams?.forEach {
            url = url.appending($0.key, value: $0.value)
        }
        
        var request = URLRequest(url: url)
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = RequestRemoteMethod.post.rawValue
        request.timeoutInterval = timeoutSec
        if let body = body {
            request.httpBody = body
        }
        return request
    }
}
