//
//  VKToken.swift
//  ClientVK
//
//  Created by Vlad on 4.12.24.
//

import Foundation

struct VKToken: Codable, Token {
    let refreshToken, accessToken: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userId = "user_id"
    }
}
