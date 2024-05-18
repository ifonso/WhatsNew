//
//  AppLogger.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 16/05/24.
//

import Foundation
import OSLog

enum Tag {
    case info
    case error
    case warning
    
    var title: String {
        switch self {
        case .info:
            return "Info"
        case .error:
            return "Error"
        case .warning:
            return "Warning"
        }
    }
}

final class AppLogger {
    
    public static let `default` = AppLogger()
    
    private let logger: Logger
    
    private init() {
        guard let bundle = Bundle.main.bundleIdentifier else {
            fatalError("Application not identified")
        }
        self.logger = Logger(subsystem: bundle, category: "appLogger")
    }
    
    func log(_ error: String, _ place: AnyObject, _ tag: Tag = .error) {
        switch tag {
        case .info:
            logger.info("----- \(tag.title) - \(place.description ?? "Undefined") \n\(error)\n-----")
        case .error:
            logger.error("----- \(tag.title) - \(place.description ?? "Undefined") \n\(error)\n-----")
        case .warning:
            logger.warning("----- \(tag.title) - \(place.description ?? "Undefined") \n\(error)\n-----")
        }
    }
}
