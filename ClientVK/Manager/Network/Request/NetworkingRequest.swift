//
//  NetworkingRequest.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

enum RequestRemoteMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol NetworkingRequest: AnyObject {
    var queryParams: [String: String]? { get set }
    var headers: [String: String]? { get set }
    
    init(urlString: String, timeoutSec: TimeInterval)
    
    func makeURLRequest() -> URLRequest?
}
