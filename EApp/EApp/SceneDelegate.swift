//
//  SceneDelegate.swift
//  EApp
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import UIKit
import EFeed
import EFeediOS
import CoreData
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?

    private lazy var remoteURL = URL(string: "https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5db4155a4fbade21d17ecd28/1572083034355/essential_app_feed.json")!
    
    /// Since iOS 14, if we don't explicitly hold a reference to the RemoteFeedLoader instance, it'll be deallocated before it completes the operation
    private lazy var remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: httpClient)
    
    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()
    
    private lazy var store: FeedStore & FeedImageDataStore = {
        try! CoreDataFeedStore(
            storeURL: NSPersistentContainer
                .defaultDirectoryURL()
                .appendingPathComponent("feed-store.sqlite"))
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    // MARK: - Init
    
    convenience init(httpClient: HTTPClient, store: FeedStore & FeedImageDataStore) {
        self.init()
        self.httpClient = httpClient
        self.store = store
    }
    
    // MARK: - Lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    // Combine
    func configureWindow() {
        let feedViewCtrl = FeedUIComposer.feedComposedWith(
            feedLoader: makeRemoteFeedLoaderWithLocalFallback,
            imageLoader: makeLocalImageLoaderWithRemoteFallback
        )
        
        window?.rootViewController = UINavigationController(rootViewController: feedViewCtrl)
        window?.makeKeyAndVisible()
    }
    
    // Swift
    /*
    func configureWindow() {
        let remoteURL = URL(string: "https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5db4155a4fbade21d17ecd28/1572083034355/essential_app_feed.json")!
        
        let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: httpClient)

        let feedLoaderCacheDecorator = FeedLoaderCacheDecorator(
            decoratee: remoteFeedLoader,
            cache: localFeedLoader
        )
        
        let feedLoaderFallback = FeedLoaderWithFallbackComposite(
            primary: feedLoaderCacheDecorator,
            fallback: localFeedLoader
        )
        
        let remoteImageLoader = RemoteFeedImageDataLoader(client: httpClient)
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
     */
    
    func sceneWillResignActive(_ scene: UIScene) {
        localFeedLoader.validateCache { _ in }
    }
}




// #option 1 - Default Init Module

/*
 //    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 //
 //        guard let scene = (scene as? UIWindowScene) else { return }
 //        window = UIWindow(windowScene: scene)
 //
 //        let url = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
 //
 //        let session = URLSession(configuration: .ephemeral)
 //        let client = URLSessionHTTPClient(session: session)
 //
 //        let feedLoader = RemoteFeedLoader(url: url, client: client)
 //        let imageLoader = RemoteFeedImageDataLoader(client: client)
 //
 //        let feedViewController = FeedUIComposer.feedComposedWith(feedLoader: feedLoader, imageLoader: imageLoader)
 //
 //        window?.rootViewController = UINavigationController(rootViewController: feedViewController)
 //        window?.makeKeyAndVisible()
 //    }
 */






// #option 2 - With Fallbacks (No Cache)

/*
 func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
 guard let scene = (scene as? UIWindowScene) else { return }
 window = UIWindow(windowScene: scene)
 
 let remoteURL = URL(string: "https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5db4155a4fbade21d17ecd28/1572083034355/essential_app_feed.json")!
 
 let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: httpClient)
 let remoteImageLoader = RemoteFeedImageDataLoader(client: httpClient)
 
 let localStoreURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite")
 
 let localStore = try! CoreDataFeedStore(storeURL: localStoreURL)
 let localFeedLoader = LocalFeedLoader(store: localStore, currentDate: Date.init)
 let localImageLoader = LocalFeedImageDataLoader(store: localStore)
 
 window?.rootViewController = FeedUIComposer.feedComposedWith(
 feedLoader: FeedLoaderWithFallbackComposite(primary: remoteFeedLoader, fallback: localFeedLoader),
 imageLoader: FeedImageDataLoaderWithFallbackComposite(primary: localImageLoader, fallback: remoteImageLoader))
 
 window?.makeKeyAndVisible()
 }
 
 */


extension SceneDelegate {
    private func makeRemoteFeedLoaderWithLocalFallback() -> FeedLoader.Publisher {
        /// Option 1
        //        return Deferred {
        //            Future { completion in
        //                // (@escaping (Result<[FeedImage], Error>) -> Void) -> Void
        //                remoteFeedLoader.load(completion: completion)
        //            }
        //        }
        
        /// Option 2
        //        return Deferred {
        //            Future(remoteFeedLoader.load)
        //        }
        return remoteFeedLoader.loadPublisher()
            .caching(to: localFeedLoader)
            .fallback(to: localFeedLoader.loadPublisher)
    }
    
    private func makeLocalImageLoaderWithRemoteFallback(url: URL) -> FeedImageDataLoader.Publisher {
        
        let remoteImageLoader = RemoteFeedImageDataLoader(client: httpClient)
        let localImageLoader = LocalFeedImageDataLoader(store: store)
        
        return localImageLoader
            .loadImageDataPublisher(from: url)
            .fallback(to: {
                remoteImageLoader
                    .loadImageDataPublisher(from: url)
                    .caching(to: localImageLoader, using: url)
            })
    }
}

