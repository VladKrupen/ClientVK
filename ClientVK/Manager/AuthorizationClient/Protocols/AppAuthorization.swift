//
//  AppAuthorization.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

protocol AppAuthorization: AnyObject {
    var delegate: AuthorizationClientDelegate? { get set }
    func requestAuthorization(type: AuthorizationType) async throws -> Token
    func handleVKAuthorizeURL(url: URL)
}
