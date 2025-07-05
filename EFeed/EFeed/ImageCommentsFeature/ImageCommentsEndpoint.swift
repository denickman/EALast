//
//  ImageCommentsEndpoint.swift
//  EFeed
//
//  Created by Denis Yaremenko on 05.07.2025.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(id):
            return baseURL.appendingPathComponent("/v1/image/\(id)/comments")
        }
    }
}
