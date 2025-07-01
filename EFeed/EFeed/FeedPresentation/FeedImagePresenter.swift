//
//  FeedImagePresenter.swift
//  EFeed
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ feed: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: feed.description,
            location: feed.location
        )
    }
}



