//
//  PostCell.swift
//  ClientVK
//
//  Created by Vlad on 3.12.24.
//

import UIKit

final class PostCell: UITableViewCell {
    
    //MARK: UI
    private let detailView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor(hex: AppColors.white2)
        return $0
    }(UIView())
    
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
    
    private let descriptionLabel: UILabel = {
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        return $0
    }(UILabel())
    
    private let counterPhotoLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 12, weight: .light)
        return $0
    }(UILabel())
    
    private let detailsVStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElements()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure
    func configureCell() {
        nameLabel.text = "Мир позитива"
        dateLabel.text = Date().getCustomFormat()
        descriptionLabel.text = "Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива"
        counterPhotoLabel.text = "10 фото"
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutDetailView()
        layoutAvatarImageView()
        layoutHeaderVStackView()
        layoutDetailsVStackView()
    }
    
    private func layoutDetailView() {
        contentView.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            detailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            detailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    private func layoutAvatarImageView() {
        detailView.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            avatarImageView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
        ])
    }
    
    private func layoutHeaderVStackView() {
        [nameLabel, dateLabel].forEach { headerVStackView.addArrangedSubview($0) }
        detailView.addSubview(headerVStackView)
        
        NSLayoutConstraint.activate([
            headerVStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            headerVStackView.trailingAnchor.constraint(lessThanOrEqualTo: detailView.trailingAnchor, constant: -10),
            headerVStackView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
    private func layoutDetailsVStackView() {
        [descriptionLabel, counterPhotoLabel].forEach { detailsVStackView.addArrangedSubview($0) }
        detailView.addSubview(detailsVStackView)
        
        NSLayoutConstraint.activate([
            detailsVStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            detailsVStackView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -10),
            detailsVStackView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            detailsVStackView.trailingAnchor.constraint(lessThanOrEqualTo: detailView.trailingAnchor, constant: -10),
        ])
    }
}
