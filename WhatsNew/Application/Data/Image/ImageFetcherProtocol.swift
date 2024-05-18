//
//  ImageFetcherProtocol.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import UIKit

protocol ImageFetcherProtocol: AnyObject {
    
    func getImage(from urlString: String) async -> UIImage?
}
