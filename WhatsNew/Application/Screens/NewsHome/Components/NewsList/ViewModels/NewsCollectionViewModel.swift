//
//  NewsCollectionViewModel.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Combine
import Foundation

protocol NewsCollectionViewModelProtocol {
    
    var articles: [Article] { get }
    var cellViewModels: PassthroughSubject<[NewsCollectionCellViewModel], Never> { get }
    var articlesCount: Int { get }
    
    func viewDidLoad()
}

final class NewsCollectionViewModel: NewsCollectionViewModelProtocol {
    
    private(set) var articles: [Article] = []
    
    private(set) var cellViewModels = PassthroughSubject<[NewsCollectionCellViewModel], Never>()
    private(set) var articlesCount: Int = 0
    
    let countryList: Country
    let newsDataSource: NewsDataSourceProtocol
    
    init(country: Country, newsDataSource: NewsDataSourceProtocol) {
        self.countryList = country
        self.newsDataSource = newsDataSource
    }
    
    func viewDidLoad() {
        self.fetchAndUpdateArticles()
    }
    
    private func fetchAndUpdateArticles() {
        Task { [weak self] in
            guard let self = self else { return }
            
            let result = await self.newsDataSource.getTopHeadlines(for: self.countryList)
            
            switch result {
            case .success(let headlinesResponse):
                // update ui models
                await self.updateArticles(articles: headlinesResponse.articles)
            case .failure(let error):
                // update UI with an error message
                AppLogger.default.log("Failed to fetch headlines: \(error.localizedDescription)", self, .warning)
            }
        }
    }
    
    private func updateArticles(articles: [Article]) async {
        let filteredArticles = filterArticles(from: articles)
        self.articles = filteredArticles
        let cellsData: [NewsCollectionCellViewModel] = await withTaskGroup(of: NewsCollectionCellViewModel?.self) { group in
            for article in filteredArticles {
                group.addTask { [weak self] in
                    guard let self = self,
                          let publishedDate = article.convertedPublishedDate
                    else {
                        return nil
                    }
                    
                    let image = await self.newsDataSource.getArticleImage(for: article)
                    return NewsCollectionCellViewModel(image: image,
                                                       title: article.title,
                                                       author: article.author,
                                                       description: article.description,
                                                       date: publishedDate)
                }
            }
            
            return await group.reduce(into: []) { partialResult, viewModel in
                if let viewModel = viewModel {
                    partialResult.append(viewModel)
                }
            }
        }
        
        await updateUIData(cellsData: cellsData.sorted(by: { $0.date.compare($1.date) == .orderedAscending }))
    }
    
    @MainActor
    private func updateUIData(cellsData: [NewsCollectionCellViewModel]) {
        self.articlesCount = cellsData.count
        self.cellViewModels.send(cellsData.sorted(by: { $0.date.compare($1.date) == .orderedAscending }))
    }
    
    // MARK: - Utility
    private func filterArticles(from articles: [Article]) -> [Article] {
        return articles.filter { article in
            !wasArticleRemoved(article.title)
        }
    }
    
    private func wasArticleRemoved(_ input: String) -> Bool {
        return input.isEmpty || input.contains("[Removed]")
    }
}
