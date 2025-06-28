//
//  FeedImageDataCache.swift
//  EFeed
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>
    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
