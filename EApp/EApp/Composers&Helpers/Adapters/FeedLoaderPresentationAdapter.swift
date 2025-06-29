//
//  FeedLoaderPresentationAdapter.swift
//  EFeediOS
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import Foundation
import EFeed
import EFeediOS
import Combine

/// Combine solution

final class FeedLoaderPresentationAdapter {
    
    var presenter: FeedPresenter?
    private var cancellable: Cancellable?
    private let feedLoader: () -> FeedLoader.Publisher
    
    init(feedLoader: @escaping () -> FeedLoader.Publisher) {
        self.feedLoader = feedLoader
    }
}

extension FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        
        cancellable = feedLoader()
            .dispatchOnMainQueue()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                    
                case .failure(let error):
                    self?.presenter?.didFinishLoadingFeed(with: error)
                }
            } receiveValue: { [weak self] feed in
                self?.presenter?.didFinishLoadingFeed(with: feed)
            }
    }
}


// Swift solution
/*
 final class FeedLoaderPresentationAdapter {
     
     private let feedLoader: FeedLoader
     var presenter: FeedPresenter?
     
     init(feedLoader: FeedLoader) {
         self.feedLoader = feedLoader
     }
 }

 extension FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
     func didRequestFeedRefresh() {
         presenter?.didStartLoadingFeed()
         
         feedLoader.load { [weak self] result in
             switch result {
                 case let .success(feed):
                 self?.presenter?.didFinishLoadingFeed(with: feed)
                 
             case let .failure(error):
                 self?.presenter?.didFinishLoadingFeed(with: error)
             }
         }
     }
 }

 */
