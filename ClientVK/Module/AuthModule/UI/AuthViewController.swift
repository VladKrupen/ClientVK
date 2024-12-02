//
//  AuthViewController.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import UIKit

final class AuthViewController: UIViewController {
    
    var viewModel: AuthViewModelProtocol?
    private let contentView = AuthView()

    //MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
