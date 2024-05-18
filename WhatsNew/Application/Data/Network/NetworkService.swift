//
//  NetworkService.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Foundation

/// HTTP methods
enum RequestMethod {
    case get
    case post
    
    var value: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetch(from url: URL,
               method: RequestMethod,
               params: [String: String]?,
               headers: [String: String]?) async -> Result<Data, NetworkServiceError> {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return .failure(.invalidURL)
        }
        
        if let params = params {
            urlComponents.queryItems = params.map { param in
                return URLQueryItem(name: param.key, value: param.value)
            }
        }
        
        guard let finalURL = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.value
        
        if let headers = headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpStatus = response as? HTTPURLResponse else {
                return .failure(.unknown)
            }
            
            guard 200..<300 ~= httpStatus.statusCode else {
                return .failure(.invalidCode(httpStatus.statusCode))
            }
            return .success(data)
            
        } catch {
            return .failure(.requestFail)
        }
    }
}
