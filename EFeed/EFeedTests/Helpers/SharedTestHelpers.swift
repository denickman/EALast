//
//  SharedTestHelpers.swift
//  EFeedTests
//
//  Created by Denis Yaremenko on 23.06.2025.
//

import Foundation
import EFeed

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    Data("any_data".utf8)
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 1)
}

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())]
}
