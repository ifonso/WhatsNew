//
//  NewsCollectionFlowLayout.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit

final class NewsCollectionFlowLayout : UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        let layoutAttributes = originalAttributes.compactMap {
            $0.copy() as? UICollectionViewLayoutAttributes
        }
        
        layoutAttributes.forEach { attributes in
            if attributes.representedElementCategory == .cell {
                if let newFrame = layoutAttributesForItem(at: attributes.indexPath)?.frame {
                    attributes.frame = newFrame
                }
            }
        }
        
        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView,
              let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        
        let safeAreaWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        let adjustedWidth = safeAreaWidth - sectionInset.left - sectionInset.right
        
        attributes.frame.origin.x = sectionInset.left
        attributes.frame.size.width = adjustedWidth
        return attributes
    }
}
