//
//  FeedImage.swift
//  EFeed
//
//  Created by Denis Yaremenko on 21.06.2025.
//

import Foundation

// Domain Model

public struct FeedImage: Decodable, Equatable {
    
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}
