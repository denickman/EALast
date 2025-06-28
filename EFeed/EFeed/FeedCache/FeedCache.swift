//
//  FeedCache.swift
//  EFeed
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
