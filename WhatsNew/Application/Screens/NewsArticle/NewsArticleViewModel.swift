//
//  NewsArticleViewModel.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 18/05/24.
//

import UIKit
import Foundation

protocol NewsArticleViewModelProtocol {
    
    var title: String { get }
    var authorsAndDate: String { get }
    var image: UIImage? { get }
    var textContent: String? { get }
    var urlLink: URL? { get }
}

final class NewsArticleViewModel: NewsArticleViewModelProtocol {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    let title: String
    let image: UIImage?
    
    private let authors: String?
    private let publishedAt: Date
    private let content: String?
    private let link: String
    
    var urlLink: URL? {
        URL(string: link)
    }
    
    var textContent: String? {
        guard let text = content else { return nil }
        return removeExtraChars(from: text)
    }
    
    var authorsAndDate: String {
        let date = dateFormatter.string(from: publishedAt)
        guard let authors = authors else {
            return date
        }
        return "\(authors) - \(date)"
    }
    
    init(title: String, 
         image: UIImage?,
         authors: String?,
         publishedAt: Date,
         content: String?,
         link: String) {
        self.title = title
        self.image = image
        self.authors = authors
        self.publishedAt = publishedAt
        self.content = content
        self.link = link
    }
    
    // MARK: - Utility
    private func removeExtraChars(from text: String) -> String {
        let pattern = "\\[\\+\\d+ chars\\]"
        if let range = text.range(of: pattern, options: .regularExpression) {
            return String(text[..<range.lowerBound])
        }
        return text
    }
}
