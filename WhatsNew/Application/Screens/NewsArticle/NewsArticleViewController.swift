//
//  NewsArticleViewController.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 14/05/24.
//

import UIKit

final class NewsArticleViewController: UIViewController {
    
    private let viewModel: NewsArticleViewModelProtocol
    
    private lazy var newsArticleView: NewsArticleView = {
        let view = NewsArticleView()
        return view
    }()
    
    init(viewModel: NewsArticleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("cant initialize this class with storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorSystem.background
        self.setupView()
        self.setupConstraints()

    }

    private func setupView() {
        view.addSubview(newsArticleView)
        newsArticleView.setupView(with: viewModel)
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.titleView?.tintColor = .blue
    }
    
    private func setupConstraints() {
        newsArticleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsArticleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsArticleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsArticleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsArticleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
