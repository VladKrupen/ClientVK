//
//  AuthView.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import UIKit

final class AuthView: BaseView {
    
    //MARK: UI
    private let logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .vkLogoImageView
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView())
    
    let vkAuthButton: VKAuthButton = {
        $0.layer.cornerRadius = 22
        return $0
    }(VKAuthButton(type: .system))
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutLogoImageView()
        layoutVKAuthButton()
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
    
    private func layoutVKAuthButton() {
        addSubview(vkAuthButton)
        
        NSLayoutConstraint.activate([
            vkAuthButton.widthAnchor.constraint(equalToConstant: 203),
            vkAuthButton.heightAnchor.constraint(equalToConstant: 44),
            
            vkAuthButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            vkAuthButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
}
