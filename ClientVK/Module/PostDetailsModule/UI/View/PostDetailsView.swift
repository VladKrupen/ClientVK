//
//  PostDetailsView.swift
//  ClientVK
//
//  Created by Vlad on 6.12.24
//

import UIKit

final class PostDetailsView: BaseView {
    
    //MARK: UI
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let headerPostView: HeaderPostView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(HeaderPostView())
    
    private let imageScrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 15
        return $0
    }(UIScrollView())
    
    private let imageStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 0
        return $0
    }(UIStackView())
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
        configure()
    }
    
    //MARK: Configure
    func configure() {
        headerPostView.configure(title: "Мир позитива", date: Date())
    }
    
    private func setupImages() {
        
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutScrollView()
        layoutHeaderPostView()
        layoutImageScrollView()
        layoutImageStackView()
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func layoutHeaderPostView() {
        contentView.addSubview(headerPostView)
        
        NSLayoutConstraint.activate([
            headerPostView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headerPostView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            headerPostView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            contentView.bottomAnchor.constraint(equalTo: headerPostView.bottomAnchor, constant: 1000)
        ])
    }
    
    private func layoutImageScrollView() {
        contentView.addSubview(imageScrollView)
        
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: headerPostView.bottomAnchor, constant: 10),
            imageScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageScrollView.heightAnchor.constraint(equalTo: imageScrollView.widthAnchor)
        ])
    }
    
    private func layoutImageStackView() {
        imageScrollView.addSubview(imageStackView)
        
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.topAnchor),
            imageStackView.bottomAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.bottomAnchor),
            imageStackView.leadingAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.trailingAnchor)
        ])
    }
}
