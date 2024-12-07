//
//  AuthViewController.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import UIKit

final class AuthViewController: BaseViewController {
    
    let viewModel: AuthViewModelProtocol
    private let contentView = AuthView()
    
    //MARK: Init
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTarget()
    }
    
    //MARK: Spiner
    func showSpiner() {
        contentView.spinerView.startAnimating()
        contentView.isUserInteractionEnabled = false
        addOverlay()
    }
    
    func hideSpiner() {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.spinerView.stopAnimating()
            self?.contentView.isUserInteractionEnabled = true
            self?.removeOverlay()
        }
    }
    
    //MARK: Target
    private func setupTarget() {
        contentView.vkAuthButton.addTarget(self, action: #selector(vkAuthButtonTapped), for: .touchUpInside)
    }
}

//MARK: OBJC
extension AuthViewController {
    @objc private func vkAuthButtonTapped() {
        viewModel.vkAuthButtonWasPressed()
    }
}
