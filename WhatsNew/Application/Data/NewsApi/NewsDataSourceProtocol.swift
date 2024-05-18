//
//  NewsDataSourceProtocol.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit

/// Entity responsible for providing news related data
protocol NewsDataSourceProtocol {
    
    func getTopHeadlines(for country: Country) async -> Result<TopHeadlinesResponse, NewsDataSourceError>
    func getArticleImage(for article: Article) async -> UIImage?
}
