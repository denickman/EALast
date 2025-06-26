//
//  FeedUIComposer.swift
//  EFeediOS
//
//  Created by Denis Yaremenko on 23.06.2025.
//

import UIKit
import EFeed
import EFeediOS

public final class FeedUIComposer {
    
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))
        let feedController = makeFeedViewController(delegate: presentationAdapter, title: FeedPresenter.title)
        
        let feedViewAdapter = FeedViewAdapter(controller: feedController, imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader))
        
        let feedPresenter = FeedPresenter(
            feedView: feedViewAdapter,
            loadingView: WeakRefVirtualProxy(feedController),
            errorView: WeakRefVirtualProxy(feedController)
        )
        
        presentationAdapter.presenter = feedPresenter
        
        return feedController
    }
    
    private static func makeFeedViewController(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let ctrl = storyboard.instantiateInitialViewController() as! FeedViewController
        ctrl.delegate = delegate
        ctrl.title = title
        return ctrl
    }
}
