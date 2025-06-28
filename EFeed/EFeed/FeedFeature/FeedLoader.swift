//
//  FeedLoader.swift
//  EFeed
//
//  Created by Denis Yaremenko on 21.06.2025.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    func load(completion: @escaping (Result) -> Void)
}
