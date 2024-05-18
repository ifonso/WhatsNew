//
//  NewsHomeViewController.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 14/05/24.
//

import UIKit

final class NewsHomeViewController: UIViewController {
    //MARK: - Screen State
    private let viewModel: NewsHomeViewModelProtocol
    
    //MARK: - Components
    private lazy var pageController: NewsPageViewController = {
        let controller = NewsPageViewController(viewControllersList: viewModel.screenControllers)
        return controller
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    private lazy var topMenu: MenuTopTabView = {
        let menu = MenuTopTabView(options: viewModel.screenList)
        return menu
    }()
    
    // MARK: - Lifecycle
    init(viewModel: NewsHomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("cant initialize this class with storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSystem.background
        
        self.setupTabBar()
        self.setupViews()
        self.setupConstraints()
        self.setupPageController()
        self.config()
    }
    
    // MARK: - Utility
    private func setupTabBar() {
        self.navigationController?.hidesBarsOnSwipe = true
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 76)
        let titleView = UILabel(frame: frame)
        titleView.font = TypographySystem.HomeView.navTitle
        titleView.text = "Top Notícias"
        titleView.textAlignment = .left
        self.navigationItem.titleView = titleView
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        topMenu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            topMenu.heightAnchor.constraint(equalToConstant: 36),
            topMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: topMenu.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupViews() {
        self.view.addSubview(contentView)
        self.view.addSubview(topMenu)
    }
    
    private func setupPageController() {
        self.addChild(pageController)
        self.contentView.addSubview(pageController.view)
        pageController.view.frame = contentView.bounds
        pageController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageController.didMove(toParent: self)
    }
    
    private func config() {
        topMenu.delegate = self
        pageController.pageChangeDelegate = self
    }
}

extension NewsHomeViewController: MenuTopTabViewDelegate, NewsPageChangeDelegate {
    /// Update top menu selection when page controller change page
    func pageChange(to index: Int) {
        guard index >= 0 && index < viewModel.screenList.count else { return }
        topMenu.updateSelectedMenu(with: index)
    }
    /// Update page controller page whenever user taps a top menu option
    func topTabViewSelected(index: Int) {
        guard index >= 0 && index < viewModel.screenList.count else { return }
        pageController.loadViewControllers(at: index)
    }
}
