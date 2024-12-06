//
//  KeyChainManager.swift
//  ClientVK
//
//  Created by Vlad on 4.12.24.
//

import Foundation
import Combine
import Security

final class KeyChainManager: TokenStorage {
    private let keyForVKToken: String = "vkTokenKey"
    
    func saveVKToken(vkToken: VKToken) -> AnyPublisher<Void, CustomError> {
        return Future { [weak self] promise in
            guard let self else { return }
            do {
                let data = try JSONEncoder().encode(vkToken)
                let query: [CFString: Any] = [
                    kSecClass: kSecClassGenericPassword,
                    kSecAttrService: keyForVKToken,
                    kSecValueData: data
                ]
                SecItemDelete(query as CFDictionary)
                let status = SecItemAdd(query as CFDictionary, nil)
                guard status == errSecSuccess else {
                    promise(.failure(.somethingWentWrong))
                    return
                }
                promise(.success(()))
            } catch {
                promise(.failure(CustomError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }
}
