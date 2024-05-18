//
//  NewsDataSource.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit
import Foundation

final class NewsDataSource: NewsDataSourceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let imageFetcher: ImageFetcherProtocol
    private let decoder = JSONDecoder()
    
    private let apiKey: String
    
    private let baseUrl = "https://newsapi.org/v2/"
    
    init(apiKey: String, networkService: NetworkServiceProtocol, imageFetcher: ImageFetcherProtocol) {
        self.apiKey = apiKey
        self.networkService = networkService
        self.imageFetcher = imageFetcher
    }
    
    func getTopHeadlines(for country: Country) async -> Result<TopHeadlinesResponse, NewsDataSourceError> {
        let url = URL(string:baseUrl + "top-headlines")!
        let params = ["country": country.urlParam,
                      "apiKey": apiKey]
        
        let result = await networkService.fetch(from: url,
                                                method: .get,
                                                params: params,
                                                headers: nil)
        
        switch result {
        case .success(let data):
            guard let response: TopHeadlinesResponse = self.decode(data) else {
                return .failure(.failDecodingResponse)
            }
            return .success(response)
        case .failure(let failure):
            AppLogger.default.log(failure.localizedDescription, self, .error)
            return .failure(.fetchError)
        }
        
    }
    
    func getArticleImage(for article: Article) async -> UIImage? {
        guard let url = article.urlToImage else { return nil }
        return await imageFetcher.getImage(from: url)
    }
    
    // MARK: - Utility
    private func decode<T: Decodable>(_ data: Data) -> T? {
        do {
            return try self.decoder.decode(T.self, from: data)
        } catch {
            AppLogger.default.log(error.localizedDescription, self, .info)
            return nil
        }
    }
}
