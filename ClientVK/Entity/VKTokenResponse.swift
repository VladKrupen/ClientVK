//
//  VKTokenResponse.swift
//  ClientVK
//
//  Created by Vlad on 4.12.24.
//

import Foundation

struct VKTokenResponse: Codable {
    let refreshToken, accessToken, idToken, tokenType: String
    let expiresIn, userID: Int
    let state, scope: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case idToken = "id_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case userID = "user_id"
        case state, scope
    }
}
