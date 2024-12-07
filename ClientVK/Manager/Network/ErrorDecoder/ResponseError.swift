//
//  ResponseError.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

struct ResponseError: Decodable {
    let error: String?
}

struct NetworkingLocalizableError: LocalizedError {
    let errorDetail: String?
    var errorDescription: String {
        errorDetail ?? "Unknown error"
    }
}
