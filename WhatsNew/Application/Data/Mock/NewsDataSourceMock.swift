//
//  NewsDataSourceMock.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 17/05/24.
//

import Foundation
import UIKit

final class NewsDataSourceMock: NewsDataSourceProtocol {
    
    func getTopHeadlines(for country: Country) async -> Result<TopHeadlinesResponse, NewsDataSourceError> {
        guard let url = Bundle.main.url(forResource: "mockData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let result = try? JSONDecoder().decode(TopHeadlinesResponse.self, from: data) else {
            return .failure(.unknown)
        }
        
        return .success(result)
    }
    
    func getArticleImage(for article: Article) async -> UIImage? {
        return nil
    }
}
