//
//  AuthView.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import UIKit

final class AuthView: UIView {
    
    //MARK: UI
    private let logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .vkLogoImageView
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView())
    
    let authButton: AuthButton = {
        $0.layer.cornerRadius = 22
        return $0
    }(AuthButton(type: .system))
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutLogoImageView()
        layoutAuthButton()
    }
    
    private func layoutLogoImageView() {
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func layoutAuthButton() {
        addSubview(authButton)
        
        NSLayoutConstraint.activate([
            authButton.widthAnchor.constraint(equalToConstant: 203),
            authButton.heightAnchor.constraint(equalToConstant: 44),
            
            authButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            authButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
}
