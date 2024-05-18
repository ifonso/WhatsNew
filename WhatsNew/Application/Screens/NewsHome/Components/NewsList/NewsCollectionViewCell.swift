//
//  NewsCollectionViewCell.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit

final class NewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: NewsCollectionViewCell.self)
    
    // MARK: - Components
    private lazy var articleImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ColorSystem.newsPlaceholderBackground
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = SpacingSystem.FeedCollectionViewCell.imageCorenerRadius
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    private lazy var imagePlaceholder: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.image = UIImage(systemName: "newspaper.fill")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = ColorSystem.newsPlaceholder
        view.isHidden = true
        return view
    }()
    
    private lazy var titleContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorSystem.primaryText
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = TypographySystem.FeedCollectionViewCell.title
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorSystem.secondaryText
        label.numberOfLines = 1
        label.font = TypographySystem.FeedCollectionViewCell.authors
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorSystem.secondaryText
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.font = TypographySystem.FeedCollectionViewCell.description
        return label
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = ColorSystem.strokeSeparator
        return view
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSelf()
    }
    
    // MARK: - Utility functions
    func config(with article: NewsCollectionCellViewModel) {
        titleLabel.text = article.title
        authorLabel.text = article.author != nil ? article.author : "fonte desconhecida"
        
        if let image = article.image {
            articleImage.image = image
            imagePlaceholder.isHidden = true
        } else {
            articleImage.image = nil
            imagePlaceholder.isHidden = false
        }
        
        if let description = article.description {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
            descriptionLabel.text = nil
        }
        
        setNeedsUpdateConstraints()
    }
    
    private func setupSelf() {
        backgroundColor = .clear
        
        contentView.addSubview(container)
        articleImage.addSubview(imagePlaceholder)
        titleContainer.addSubview(titleLabel)
        titleContainer.addSubview(authorLabel)
        
        container.addSubview(articleImage)
        container.addSubview(titleContainer)
        container.addSubview(descriptionLabel)
        container.addSubview(bottomLine)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        imagePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SpacingSystem.large),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -SpacingSystem.large),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SpacingSystem.large),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -SpacingSystem.large),
            
            articleImage.topAnchor.constraint(equalTo: container.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            articleImage.heightAnchor.constraint(equalToConstant: SpacingSystem.FeedCollectionViewCell.newsImageSize.height),
            articleImage.widthAnchor.constraint(equalToConstant: SpacingSystem.FeedCollectionViewCell.newsImageSize.width),
            
            imagePlaceholder.topAnchor.constraint(equalTo: articleImage.topAnchor, constant: SpacingSystem.large),
            imagePlaceholder.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: -SpacingSystem.large),
            imagePlaceholder.leadingAnchor.constraint(equalTo: articleImage.leadingAnchor, constant: SpacingSystem.large),
            imagePlaceholder.trailingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: -SpacingSystem.large),
            
            titleContainer.topAnchor.constraint(equalTo: articleImage.topAnchor),
            titleContainer.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor),
            titleContainer.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: SpacingSystem.large),
            titleContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: SpacingSystem.small),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: SpacingSystem.large),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func updateDescriptionLabelConstraints() {
        if descriptionLabel.isHidden {
            descriptionLabel.removeConstraints(descriptionLabel.constraints)
        } else {
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: SpacingSystem.large),
                descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        }
    }
    
    override func updateConstraints() {
        updateDescriptionLabelConstraints()
        super.updateConstraints()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
                                                                          withHorizontalFittingPriority: .required,
                                                                          verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}
