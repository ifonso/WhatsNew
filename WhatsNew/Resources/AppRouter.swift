//
//  AppRouter.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 17/05/24.
//

import UIKit
import Foundation

protocol RouterProtocol: AnyObject {
    
    func start()
    func navigateToDetails(with article: ArticleDetails)
}

final class AppRouter: RouterProtocol {
    /// Enumerated menus that can be used to fetch article data
    private let menus = Country.allCases
    
    private let navigationController: UINavigationController
    private let viewModelProvder: ViewModelProvider
    
    init(navigationController: UINavigationController, viewModelProvder: ViewModelProvider) {
        self.navigationController = navigationController
        self.viewModelProvder = viewModelProvder
    }
    
    func start() {
        let homeViewController = NewsHomeViewController(
            viewModel: viewModelProvder.getHomeViewModel(screenList: menus, router: self)
        )
        self.navigationController.viewControllers = [homeViewController]
    }
    
    func navigateToDetails(with article: ArticleDetails) {
        let newsArticleControler = NewsArticleViewController(
            viewModel: viewModelProvder.getNewsArticleViewModel(with: article)
        )
        self.navigationController.pushViewController(newsArticleControler, animated: true)
    }
}
