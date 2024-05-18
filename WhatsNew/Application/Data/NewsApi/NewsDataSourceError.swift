//
//  NewsDataSourceError.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Foundation

enum NewsDataSourceError: Error {
    case failDecodingResponse
    case fetchError
    case unknown
}
