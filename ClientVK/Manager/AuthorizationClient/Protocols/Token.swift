//
//  Token.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

protocol Token {
    var accessToken: String { get }
    var refreshToken: String { get }
}
