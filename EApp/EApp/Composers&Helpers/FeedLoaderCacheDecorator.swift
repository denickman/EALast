//
//  FeedLoaderCacheDecorator.swift
//  EApp
//
//  Created by Denis Yaremenko on 25.06.2025.
//

import EFeed
import Combine

public final class FeedLoaderCacheDecorator: FeedLoader {
    
    private let decoratee: FeedLoader
    private let cache: FeedCache
    
    public init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            /// #option 1
            /*
             // option 1.1
             if let feed = try? result.get() {
             self?.cache.save(feed, completion: { result in
             
             })
             }`
             
             // option 1.2
             if case let .success(feed) = result {
             self?.cache.save(feed) { _ in }
             }
             
             completion(result)
             */
            
            /// #option 1
            completion(result.map { feed in
                self?.cache.saveIgnoringResult(feed) // ignoring the result in that case
                return feed
            })
            
        }
    }
}
