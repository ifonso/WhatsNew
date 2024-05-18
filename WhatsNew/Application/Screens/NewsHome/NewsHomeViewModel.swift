//
//  NewsHomeViewModel.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit
import Foundation

protocol NewsHomeViewModelProtocol {
    
    var screenList: [MenuOptionProtocol] { get }
    var screenControllers: [UIViewController] { get }
}

final class NewsHomeViewModel: NewsHomeViewModelProtocol {
    
    let screenList: [MenuOptionProtocol]
    let screenControllers: [UIViewController]
    
    init(screenList: [MenuOptionProtocol], screenControllers: [UIViewController]) {
        self.screenControllers = screenControllers
        self.screenList = screenList
    }
}
