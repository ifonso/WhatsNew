//
//  String+sizeForFont.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 14/05/24.
//

import UIKit

extension String {
    /// Get the frame for a lable with a specific font used
    func sizeFor(font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
