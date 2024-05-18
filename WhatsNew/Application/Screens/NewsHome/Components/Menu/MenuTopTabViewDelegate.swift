//
//  MenuTopTabViewDelegate.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 18/05/24.
//

import Foundation

/// Responsible for dealing with screen change on menu tapped
protocol MenuTopTabViewDelegate: AnyObject {
    
    func topTabViewSelected(index: Int)
}
