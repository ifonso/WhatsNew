//
//  NetworkServiceError.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Foundation

/// Default network errors
enum NetworkServiceError: Error {
    case invalidCode(Int)
    case invalidURL
    case requestFail
    case unknown
}
