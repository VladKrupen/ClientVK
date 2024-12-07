//
//  NetworkingHTTPClient.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

protocol NetworkingHTTPClient: AnyObject {
    typealias Result = (data: Data, response: HTTPURLResponse)
    func makeRequest(_ request: NetworkingRequest) async throws -> Result
}
