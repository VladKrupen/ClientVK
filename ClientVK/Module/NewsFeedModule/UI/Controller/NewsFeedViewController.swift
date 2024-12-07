//
//  NewsFeedViewController.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import UIKit

final class NewsFeedViewController: BaseViewController {
    
    let viewModel: NewsFeedViewModelProtocol
    private let contentView = NewsFeedView()
    
    //MARK: Init
    init(viewModel: NewsFeedViewModelProtocol) {
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
        setupNavigationController()
        setDelegates()
    }
    
    //MARK: Setup NavigationController
    private func setupNavigationController() {
        navigationItem.title = Titles.newsFeed
    }
    
    //MARK: Delegates
    private func setDelegates() {
        contentView.newsFeedTableView.dataSource = self
        contentView.newsFeedTableView.delegate = self
    }
}

//MARK: UITableViewDataSource
extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: UITableViewDelegate
extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToPostDetailModule()
    }
}
