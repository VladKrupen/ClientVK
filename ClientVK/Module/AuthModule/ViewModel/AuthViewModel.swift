//
//  AuthViewModel.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import Foundation

protocol AuthViewModelProtocol: AnyObject {
    var completionHandler: (() -> Void)? { get set }
    func authButtonWasPressed()
}

final class AuthViewModel: AuthViewModelProtocol {
    var completionHandler: (() -> Void)?
}

//MARK: AuthViewModelProtocol
extension AuthViewModel {
    func authButtonWasPressed() {
        completionHandler?()
    }
}
