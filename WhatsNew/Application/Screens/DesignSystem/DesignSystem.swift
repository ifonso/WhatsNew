//
//  DesignSystem.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit

struct SpacingSystem {
    // Base spacing system
    static let small: CGFloat = 4
    static let medium: CGFloat = 8
    static let large: CGFloat = 16
    static let xlarge: CGFloat = 32
    
    /// Specs for news feed cells
    struct FeedCollectionViewCell {
        // image
        static let newsImageSize = CGSize(width: 64, height: 64)
        static let imageCorenerRadius: CGFloat = 8
    }
}

struct TypographySystem {
    /// Fonts used in home
    struct HomeView {
        static let navTitle = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize)
    }
    
    /// Fonsts used for article cells
    struct FeedCollectionViewCell {
        static let title = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .medium)
        static let authors = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .regular)
        static let description = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .footnote).pointSize, weight: .regular)
    }
    /// Fonsts used for article detail views
    struct ArticleView {
        static let title = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
        static let date = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).pointSize, weight: .regular)
        static let content = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        static let link = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .callout).pointSize, weight: .regular)
    }
}

struct ColorSystem {
    // Text
    static let primaryText = UIColor(named: "PrimaryText")
    static let secondaryText = UIColor(named: "SecondaryText")
    // Components
    static let activeComponent = UIColor(named: "ActiveComponent")
    static let deactiveComponent = UIColor(named: "DeactiveComponent")
    static let grayStroke = UIColor(named: "StrokeGray")
    static let strokeSeparator = UIColor(named: "StrokeSeparator")
    static let newsPlaceholder = UIColor(named: "NewsPlaceholder")
    // Backgrounds
    static let background = UIColor(named: "Background")
    static let newsPlaceholderBackground = UIColor(named: "NewsPlaceholderBackground")
}
