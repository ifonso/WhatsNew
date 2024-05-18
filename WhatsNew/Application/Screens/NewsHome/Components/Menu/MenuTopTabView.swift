//
//  MenuTopTabVeiw.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 14/05/24.
//

import UIKit

final class MenuTopTabView: UIView {
    // MARK: - State
    /// Selected menu
    private var selectedMenu: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    /// Variable used to know when to animate selection transition
    private var isFirstTime: Bool = true
    
    weak var delegate: MenuTopTabViewDelegate?
    
    /// Menu font
    private let titleFont: UIFont = UIFont.preferredFont(forTextStyle: .subheadline)
    private let menuList: [MenuOptionProtocol]
    
    // MARK: - Components
    /// Selected black bottom line
    private lazy var selectedLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorSystem.activeComponent
        view.layer.zPosition = 10
        return view
    }()
    
    /// Gray bottom line
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorSystem.grayStroke
        view.layer.zPosition = 2
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Initializers & Lifecycle
    init(options: [MenuOptionProtocol]) {
        self.menuList = options
        super.init(frame: .zero)
        self.customInitializer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("cant initialize this class with storyboard")
    }
    
    private func customInitializer() {
        self.registerCell()
        self.setupContraints()
        self.collectionView.backgroundColor = .clear
    }
    
    private func registerCell() {
        collectionView.register(MenuTopTabViewCell.self, forCellWithReuseIdentifier: MenuTopTabViewCell.identifier)
    }
    
    private func setupContraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(lineView)
        self.addSubview(collectionView)
        self.addSubview(selectedLineView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - Utility
    func updateSelectedMenu(with index: Int) {
        guard index < menuList.count else { return }
        self.selectedMenu = index
    }
    
    private func moveSelectedLineView(to frame: CGRect, animating: Bool) {
        let newFrame = CGRect(x: frame.minX,
                              y: self.frame.height - 1,
                              width: frame.width,
                              height: 1)
        
        if animating {
            UIView.animate(withDuration: 0.3) {
                self.selectedLineView.frame = newFrame
            }
        } else {
            self.selectedLineView.frame = newFrame
        }
    }
}

extension MenuTopTabView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuTopTabViewCell.identifier,
            for: indexPath)
        as? MenuTopTabViewCell ?? MenuTopTabViewCell()
        
        cell.setTitle(with: menuList[indexPath.item].string, font: titleFont)
        cell.setStateWith(active: indexPath.item == selectedMenu)
        
        // Ajust selected line
        if indexPath.item == selectedMenu {
            moveSelectedLineView(to: cell.frame, animating: !isFirstTime)
            isFirstTime = false
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        selectedMenu = indexPath.item
        delegate?.topTabViewSelected(index: selectedMenu)
    }
}

extension MenuTopTabView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textSize = menuList[indexPath.item]
            .string
            .sizeFor(font: titleFont)
        
        return CGSize(width: textSize.width + 1 + SpacingSystem.large*2, height: textSize.height + SpacingSystem.medium*2)
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
