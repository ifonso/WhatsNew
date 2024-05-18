//
//  ViewModelProvider.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 17/05/24.
//

import UIKit
import Foundation

/// Class responsible for creating global services and providing viewModels for entire application
final class ViewModelProvider {
    
    private let networkService: NetworkServiceProtocol
    private let imageFetcher: ImageFetcherProtocol
    private let newsApiKey: String
    
    init(newsApiKey: String) {
        let networkService = NetworkService()
        let imageFetcher = ImageFetcher(networkService: networkService)
        // Global services
        self.networkService = networkService
        self.imageFetcher = imageFetcher
        self.newsApiKey = newsApiKey
    }
    
    func getHomeViewModel(screenList: [Country], router: RouterProtocol) -> NewsHomeViewModelProtocol {
        let countryCollectionControllers: [UIViewController] = screenList.map { menu in
            NewsCollectionViewController(viewModel: getNewsCollectionViewModel(for: menu),
                                         router: router)
        }
        return NewsHomeViewModel(screenList: screenList, screenControllers: countryCollectionControllers)
    }
    
    func getNewsCollectionViewModel(for country: Country) -> NewsCollectionViewModelProtocol {
        let newsDataSource = NewsDataSource(apiKey: newsApiKey,
                                            networkService: networkService,
                                            imageFetcher: imageFetcher)
        
        return NewsCollectionViewModel(country: country,
                                       newsDataSource: newsDataSource)
    }
    
    func getNewsArticleViewModel(with data: ArticleDetails) -> NewsArticleViewModelProtocol {
        return NewsArticleViewModel(title: data.title,
                                    image: data.image,
                                    authors: data.author,
                                    publishedAt: data.publishedAt,
                                    content: data.content,
                                    link: data.url)
    }
}
