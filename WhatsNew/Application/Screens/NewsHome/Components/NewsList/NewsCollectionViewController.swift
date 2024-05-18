//
//  NewsCollectionViewController.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit
import Combine

final class NewsCollectionViewController: UIViewController {
    
    private weak var router: RouterProtocol?
    
    // MARK: - Components
    private lazy var collectionView: UICollectionView = {
        let layout = NewsCollectionFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collection.contentInsetAdjustmentBehavior = .always
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    // MARK: - State & ViewModels
    private let viewModel: NewsCollectionViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var cellViewModels: [NewsCollectionCellViewModel] = []
    private var cellsCount: Int = 0
    
    // MARK: - Initializer & lifecycle
    init(viewModel: NewsCollectionViewModelProtocol, router: RouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("cant initialize this class with storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupConstraints()
        self.bindViewModelData()
        self.viewModel.viewDidLoad()
    }
    
    // MARK: - Utility
    private func bindViewModelData() {
        viewModel.cellViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cellsData in
                self?.cellViewModels = cellsData
                self?.cellsCount = cellsData.count
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension NewsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewsCollectionViewCell.identifier,
            for: indexPath)
        as? NewsCollectionViewCell ?? NewsCollectionViewCell()
        // TODO: Config bug
        cell.config(with: cellViewModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        // Navigate to article datials screen
        let article = viewModel.articles[indexPath.item]
        let articleCellData = cellViewModels[indexPath.item]
        let articleDetails = ArticleDetails(title: articleCellData.title,
                                            image: articleCellData.image,
                                            url: article.url,
                                            author: articleCellData.author,
                                            content: article.content,
                                            publishedAt: articleCellData.date)
        
        router?.navigateToDetails(with: articleDetails)
    }
}
