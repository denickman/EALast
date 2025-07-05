//
//  FeedUIComposer.swift
//  EFeediOS
//
//  Created by Denis Yaremenko on 23.06.2025.
//

import UIKit
import EFeed
import EFeediOS
import Combine

public final class FeedUIComposer {
    
    private init() {}
    
    // Comibne
    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>,
        imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher,
        selection: @escaping (FeedImage) -> Void = { _ in }
    ) -> ListViewController {
        
        let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(
            loader: {
                feedLoader()
                    .dispatchOnMainQueue()
            })
        
        let feedController = makeFeedViewController(title: FeedPresenter.title)
        feedController.onRefresh = presentationAdapter.loadResource
        
        let feedViewAdapter = FeedViewAdapter(
            controller: feedController,
            imageLoader: { imageLoader($0).dispatchOnMainQueue() },
            selection: selection
        )
        
        let resourcePresenter = LoadResourcePresenter(
            resourceView: feedViewAdapter,
            loadingView: WeakRefVirtualProxy(feedController),
            errorView: WeakRefVirtualProxy(feedController),
            mapper: FeedPresenter.map
        )
        
        presentationAdapter.presenter = resourcePresenter
        
        return feedController
    }
    
    // Simple
    /*
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
     */

    private static func makeFeedViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let ctrl = storyboard.instantiateInitialViewController() as! ListViewController
        ctrl.title = title
        return ctrl
    }
}
