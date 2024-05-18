//
//  NetworkServiceProtocol.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Foundation

/// Service responsible for api calls
protocol NetworkServiceProtocol {
    func fetch(from url: URL,
               method: RequestMethod,
               params: [String: String]?,
               headers: [String: String]?) async -> Result<Data, NetworkServiceError>
}
