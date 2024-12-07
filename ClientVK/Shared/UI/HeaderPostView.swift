//
//  HeaderPostView.swift
//  ClientVK
//
//  Created by Vlad on 6.12.24.
//

import UIKit

final class HeaderPostView: BaseView {
    
    //MARK: UI
    private let avatarImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .white
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let dateLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 12, weight: .light)
        return $0
    }(UILabel())
    
    private let headerVStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    //MARK: Configure
    func configure(title: String, date: Date) {
        nameLabel.text = title
        dateLabel.text = date.getCustomFormat()
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutAvatarImageView()
        layoutHeaderVStackView()
    }
    
    private func layoutAvatarImageView() {
        addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func layoutHeaderVStackView() {
        [nameLabel, dateLabel].forEach { headerVStackView.addArrangedSubview($0) }
        addSubview(headerVStackView)
        
        NSLayoutConstraint.activate([
            headerVStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            headerVStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            headerVStackView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
}
