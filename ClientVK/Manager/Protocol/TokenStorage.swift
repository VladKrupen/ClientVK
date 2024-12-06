//
//  TokenStorage.swift
//  ClientVK
//
//  Created by Vlad on 4.12.24.
//

import Foundation
import Combine

protocol TokenStorage: AnyObject {
    func saveVKToken(vkToken: VKToken) -> AnyPublisher<Void, CustomError>
}
