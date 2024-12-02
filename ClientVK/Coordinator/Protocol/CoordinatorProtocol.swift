//
//  CoordinatorProtocol.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

protocol CoordinatorProtocol: AnyObject, AppCoordinatorProtocol {
    var flowCompletionHandler: (() -> Void)? { get set }
}
