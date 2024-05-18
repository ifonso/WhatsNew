//
//  Country.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 17/05/24.
//

import Foundation

/// Enum with countries supported by the app and the api
enum Country: Int, CaseIterable, MenuOptionProtocol {
    case br = 0
    case us = 1
    
    var string: String {
        switch self {
        case .br:
            return "Brasil"
        case .us:
            return "Estados Unidos"
        }
    }
    
    var urlParam: String {
        switch self {
        case .br:
            return "br"
        case .us:
            return "us"
        }
    }
}
