//
//  Article.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 14/05/24.
//

import Foundation


struct Article: Decodable {
    
    let source: ArticleSource
    let title: String
    let url: String
    
    let author: String?
    let description: String?
    let urlToImage: String?
    let content: String?
    
    let publishedAt: String
    
    var convertedPublishedDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: self.publishedAt)
    }
}


struct ArticleSource: Decodable {
    
    let id: String?
    let name: String
}
