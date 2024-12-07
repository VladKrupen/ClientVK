//
//  ResponseErrorDecoder.swift
//  ClientVK
//
//  Created by Vlad on 7.12.24.
//

import Foundation

final class ResponseErrorDecoder {
    func decode(response: HTTPURLResponse, data: Data) -> Swift.Error? {
        guard !(200...299).contains(response.statusCode) else { return nil }
        
        do {
            let error = try JSONDecoder().decode(ResponseError.self, from: data)
            return NetworkingLocalizableError(errorDetail: error.error)
        } catch {
            return NetworkingLocalizableError(errorDetail: "Unexpected error format.")
        }
    }
}
