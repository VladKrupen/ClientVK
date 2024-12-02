//
//  AuthButton.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit

final class AuthButton: UIButton {
    
    //MARK: UI
    private let vkLogoImageView: UIImageView = {
        $0.image = .vkLogoAuthButton
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView(frame: .init(x: 0, y: 0, width: 28, height: 28)))
    
    private let signInLabel: UILabel = {
        $0.text = Titles.signIn
        $0.textColor = UIColor(hex: AppColors.white)
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        return $0
    }(UILabel())
    
    private let hStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 10
        $0.isUserInteractionEnabled = false
        return $0
    }(UIStackView())
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: AppColors.blue)
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutHStackView()
    }
    
    private func layoutHStackView() {
        [vkLogoImageView, signInLabel].forEach { hStackView.addArrangedSubview($0) }
        addSubview(hStackView)
        
        NSLayoutConstraint.activate([
            hStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            hStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
