//
//  NewsResponse.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Foundation

/// Response object for top headlines api endpoint
struct TopHeadlinesResponse: Decodable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
}
