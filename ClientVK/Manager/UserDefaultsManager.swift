//
//  UserDefaultsManager.swift
//  ClientVK
//
//  Created by Vlad on 6.12.24.
//

import Foundation

final class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard
    private let authorizationKey = "authorizationKey"
}

extension UserDefaultsManager: UserAuthorization {
    var isUserAuthorized: Bool {
        get {
            return userDefaults.bool(forKey: authorizationKey)
        }
        set {
            userDefaults.set(newValue, forKey: authorizationKey)
        }
    }
}
