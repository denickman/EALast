//
//  FeedImageViewModel.swift
//  EFeed
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import Foundation

public struct FeedImageViewModel {
    // we do not any detail about loading an image
    public let description: String?
    public let location: String?
     
    public var hasLocation: Bool {
        return location != nil
    }
}

