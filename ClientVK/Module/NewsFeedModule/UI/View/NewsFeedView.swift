//
//  NewsFeedView.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import UIKit

final class NewsFeedView: UIView {
    
    //MARK: UI
    let newsFeedTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
        return $0
    }(UITableView())
    
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
        layoutNewsFeedTableView()
    }
    
    private func layoutNewsFeedTableView() {
        addSubview(newsFeedTableView)
        
        NSLayoutConstraint.activate([
            newsFeedTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsFeedTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            newsFeedTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsFeedTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
