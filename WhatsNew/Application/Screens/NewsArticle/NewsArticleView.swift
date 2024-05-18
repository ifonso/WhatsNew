//
//  NewsArticleView.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 18/05/24.
//

import UIKit

final class NewsArticleView: UIView {
    
    // MARK: - Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographySystem.ArticleView.title
        label.textColor = ColorSystem.primaryText
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = TypographySystem.ArticleView.date
        label.textColor = ColorSystem.secondaryText
        return label
    }()
    
    private lazy var articleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = ColorSystem.newsPlaceholderBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var articleImagePlaceholder: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        view.image = UIImage(systemName: "newspaper.fill")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = ColorSystem.newsPlaceholder
        view.isHidden = true
        return view
    }()
    
    private lazy var contentText: UILabel = {
        let label = UILabel()
        label.tintColor = ColorSystem.primaryText
        label.font = TypographySystem.ArticleView.content
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var link: UILabel = {
        let label = UILabel()
        label.text = "Continuar Lendo..."
        label.textColor = .link
        label.font = TypographySystem.ArticleView.link
        return label
    }()
    
    // MARK: - Setup
    private var resourceLink: URL?
    
    func setupView(with viewModel: NewsArticleViewModelProtocol) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.authorsAndDate
        resourceLink = viewModel.urlLink
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleLinkTap))
        link.addGestureRecognizer(tap)
        link.isUserInteractionEnabled = true
        
        if let image = viewModel.image {
            articleImageView.image = image
            articleImagePlaceholder.isHidden = true
        } else {
            articleImageView.image = nil
            articleImagePlaceholder.isHidden = false
        }
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        articleImageView.addSubview(articleImagePlaceholder)
        addSubview(articleImageView)
        addSubview(link)
        
        if let text = viewModel.textContent {
            contentText.isHidden = false
            contentText.text = text
            addSubview(contentText)
        } else {
            contentText.isHidden = true
        }
        
        setupConstraints()
    }
    
    // MARK: - Utility
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImagePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        contentText.translatesAutoresizingMaskIntoConstraints = false
        link.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: SpacingSystem.large),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SpacingSystem.large),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SpacingSystem.large),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: SpacingSystem.small),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SpacingSystem.large),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SpacingSystem.large),
            
            articleImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: SpacingSystem.large),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SpacingSystem.large),
            articleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SpacingSystem.large),
            articleImageView.heightAnchor.constraint(equalToConstant: 180),
            
            articleImagePlaceholder.topAnchor.constraint(equalTo: articleImageView.topAnchor, constant: SpacingSystem.xlarge * 1.75),
            articleImagePlaceholder.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: -SpacingSystem.xlarge * 1.75),
            articleImagePlaceholder.centerXAnchor.constraint(equalTo: articleImageView.centerXAnchor)
        ])
        
        if contentText.isHidden {
            NSLayoutConstraint.activate([
                link.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: SpacingSystem.xlarge),
                link.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SpacingSystem.large),
                link.trailingAnchor.constraint(equalTo: trailingAnchor, constant: SpacingSystem.large)
            ])
        } else {
            NSLayoutConstraint.activate([
                contentText.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: SpacingSystem.xlarge),
                contentText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SpacingSystem.large),
                contentText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SpacingSystem.large),
                
                link.topAnchor.constraint(equalTo: contentText.bottomAnchor, constant: SpacingSystem.xlarge),
                link.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SpacingSystem.large),
                link.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SpacingSystem.large)
            ])
        }
    }
    
    @objc
    private func handleLinkTap() {
        guard let link = resourceLink else { return }
        UIApplication.shared.open(link)
    }
}
