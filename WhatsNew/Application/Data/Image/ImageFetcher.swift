//
//  ImageFetcher.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Foundation
import UIKit

/// Image fetcher implementation with image cache
final class ImageFetcher: ImageFetcherProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let imageCache: NSCache<NSString, UIImage>
    
    private let lock = NSLock()
    private let cacheConfig = CacheConfig(countLimit: 100,
                                          memoryLimit: 1024 * 1024 * 20) // 20 MB
    
    private struct CacheConfig {
        let countLimit: Int
        let memoryLimit: Int
    }
    
    init(networkService: NetworkServiceProtocol) {
        // network
        self.networkService = networkService
        // Cache
        self.imageCache = NSCache<NSString, UIImage>()
        self.imageCache.countLimit = cacheConfig.countLimit
        self.imageCache.totalCostLimit = cacheConfig.memoryLimit
    }
    
    func getImage(from urlString: String) async -> UIImage? {
        if let cachedImage = getImageFromCache(with: urlString) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let result = await networkService.fetch(from: url,
                                                method: .get,
                                                params: nil,
                                                headers: nil)
        
        switch result {
        case .success(let data):
            guard let downloadedImage = UIImage(data: data) else {
                return nil
            }
            saveImageInCache(image: downloadedImage, url: urlString)
            return downloadedImage
        case .failure(let error):
            AppLogger.default.log(error.localizedDescription, self, .warning)
            return nil
        }
    }
    
    // MARK: - Cache utility
    private func getImageFromCache(with url: String) -> UIImage? {
        lock.lock()
        defer { lock.unlock() }
        
        guard let image = imageCache.object(forKey: NSString(string: url)) else {
            return nil
        }
        
        return image
    }
    
    private func saveImageInCache(image: UIImage, url: String) {
        lock.lock()
        defer { lock.unlock() }
        imageCache.setObject(image, forKey: NSString(string: url))
    }
}
