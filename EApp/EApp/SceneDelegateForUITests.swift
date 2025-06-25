//
//  SceneDelegateForUITests.swift
//  EApp
//
//  Created by Denis Yaremenko on 25.06.2025.
//

import UIKit
import EFeed
import EFeediOS
import CoreData

/// For EssentialAppUIAcceptanceTests


/*
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let localStore = NSPersistentContainer
        .defaultDirectoryURL()
        .appendingPathComponent("feed-store.sqlite")
    
    private lazy var store: FeedStore & FeedImageDataStore = {
        try! CoreDataFeedStore(
            storeURL: NSPersistentContainer
                .defaultDirectoryURL()
                .appendingPathComponent("feed-store.sqlite"))
    }()
    
    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let remoteURL = URL(string: "https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5db4155a4fbade21d17ecd28/1572083034355/essential_app_feed.json")!
        
        let remoteClient = makeRemoteClient()
        
        let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: remoteClient)
        
        let feedLoaderCacheDecorator = FeedLoaderCacheDecorator(
            decoratee: remoteFeedLoader,
            cache: localFeedLoader
        )
        
        let feedLoaderFallback = FeedLoaderWithFallbackComposite(
            primary: feedLoaderCacheDecorator,
            fallback: localFeedLoader
        )
        
        let remoteImageLoader = RemoteFeedImageDataLoader(client: remoteClient)
        let localImageLoader = LocalFeedImageDataLoader(store: store)
        
        let imageLoderCacheDecorator = FeedImageDataLoaderCacheDecorator(
            decoratee: remoteImageLoader,
            cache: localImageLoader
        )
        
        let imageLoaderFallback = FeedImageDataLoaderWithFallbackComposite(
            primary: localImageLoader,
            fallback: imageLoderCacheDecorator
        )
        
        let feedViewCtrl = FeedUIComposer.feedComposedWith(
            feedLoader: feedLoaderFallback,
            imageLoader: imageLoaderFallback
        )
        
        window?.rootViewController = UINavigationController(rootViewController: feedViewCtrl)
        window?.makeKeyAndVisible()
    }
    
    func makeRemoteClient() -> HTTPClient {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }
    
}

*/
