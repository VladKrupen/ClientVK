//
//  NewsFeedViewModel.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24
//

import Foundation

protocol NewsFeedViewModelProtocol: AnyObject {
    var navigateTo: ((NewsFeedNavigation) -> Void)? { get set }
    func navigateToPostDetailModule()
}

final class NewsFeedViewModel: NewsFeedViewModelProtocol {
    var navigateTo: ((NewsFeedNavigation) -> Void)?
}

//MARK: NewsFeedViewModelProtocol
extension NewsFeedViewModel {
    func navigateToPostDetailModule() {
        navigateTo?(.postDetails)
    }
}
