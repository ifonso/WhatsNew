//
//  MenuTopTabViewCell.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 14/05/24.
//

import UIKit

final class MenuTopTabViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MenuTopTabViewCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSelf()
    }
    
    func setTitle(with text: String, font: UIFont) {
        titleLabel.text = text
        titleLabel.font = font
    }
    
    func setStateWith(active: Bool) {
        UIView.transition(with: titleLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.titleLabel.textColor = active ? ColorSystem.activeComponent : ColorSystem.deactiveComponent
        }
    }
    
    private func setupSelf() {
        backgroundColor = .clear
        addSubview(titleLabel)
        setupConstraints()
        setStateWith(active: false)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: SpacingSystem.medium),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -SpacingSystem.medium),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SpacingSystem.large),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SpacingSystem.large)
        ])
    }
}
