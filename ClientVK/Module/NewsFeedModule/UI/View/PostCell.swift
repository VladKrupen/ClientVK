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
    
    private let headerPostView: HeaderPostView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(HeaderPostView())
    
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
        headerPostView.configure(title: "Мир позитива", date: Date())
        descriptionLabel.text = "Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива Мир позитива позитива"
        counterPhotoLabel.text = "10 фото"
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutDetailView()
        layoutHeaderPostView()
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
    
    private func layoutHeaderPostView() {
        detailView.addSubview(headerPostView)
        
        NSLayoutConstraint.activate([
            headerPostView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 10),
            headerPostView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            headerPostView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10)
        ])
    }
    
    private func layoutDetailsVStackView() {
        [descriptionLabel, counterPhotoLabel].forEach { detailsVStackView.addArrangedSubview($0) }
        detailView.addSubview(detailsVStackView)
        
        NSLayoutConstraint.activate([
            detailsVStackView.topAnchor.constraint(equalTo: headerPostView.bottomAnchor, constant: 10),
            detailsVStackView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -10),
            detailsVStackView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            detailsVStackView.trailingAnchor.constraint(lessThanOrEqualTo: detailView.trailingAnchor, constant: -10),
        ])
    }
}
