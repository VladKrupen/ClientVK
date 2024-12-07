//
//  VKAuthorization.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

protocol VKAuthorization: AnyObject {
    func generateSafariAuthURL() -> URL?
    func requestTokens(url: URL?) async throws -> VKToken
}
