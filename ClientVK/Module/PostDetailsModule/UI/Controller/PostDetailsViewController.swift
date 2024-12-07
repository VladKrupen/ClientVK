//
//  PostDetailsViewController.swift
//  ClientVK
//
//  Created by Vlad on 6.12.24
//

import UIKit

final class PostDetailsViewController: BaseViewController {
    
    let viewModel: PostDetailsViewModelProtocol
    private let contentView = PostDetailsView()
    
    //MARK: Init
    init(viewModel: PostDetailsViewModelProtocol) {
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

    }
}
