//
//  AppCoordinatorProtocol.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
