//
//  AuthenticationManager.swift
//  ClientVK
//
//  Created by Vlad on 3.12.24.
//

import Foundation
import Combine

protocol AuthenticationManager: AnyObject {
    func getAuthorizationUrl() -> URL?
    func getTokens(url: URL?) -> AnyPublisher<VKToken, CustomError>
}
