//
//  EssentialAppUIAcceptanceTests.swift
//  EAppUIAcceptanceTests
//
//  Created by Denis Yaremenko on 25.06.2025.
//

import XCTest

// uncomment SceneDelegateDebuggingForUITests + SceneDelegateForUITests
// Currently we use FeedAcceptanceTests for this purpose

/*

final class EssentialAppUIAcceptanceTests: XCTestCase {
    
    // when hte customer has connectivity
    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
        let app = XCUIApplication()
        //  Xcode автоматически добавляет launchArguments в UserDefaults твоего приложения, если ты используешь ключи в формате -key value — и только при старте через UI-тест.
        // В момент запуска устанавливает в UserDefaults ключ connectivity = online внутри тестируемого приложения.
       //  Это делается в рантайме, перед запуском SceneDelegate.
        // "-reset"- доступ только через command line
        
        app.launchArguments = ["-reset", "-connectivity", "online"]
        app.launch()
        
        let feedCells = app.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(feedCells.count, 2)
        
        let feedImage = app.images.matching(identifier: "feed-image-view").firstMatch
        XCTAssertTrue(feedImage.exists)
    }
    
    // has not connectivity but has cache
    func test_onLaunch_displaysCachedRemoteFeedWhenCustomerHasNoConnectivity() {
        // launch. connection online. store cache
        // first launch reset everything
        let onlineApp = XCUIApplication()
        onlineApp.launchArguments = ["-reset", "-connectivity", "online"]
        onlineApp.launch()
        
        // launch again. connection offline. check cache
        // second launch turn the network off
        let offlineApp = XCUIApplication()
        offlineApp.launchArguments = ["-connectivity", "offline"]
        offlineApp.launch()
        
        let cachedFeedCells = offlineApp.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(cachedFeedCells.count, 2)
        
        let firstCachedImage = offlineApp.images.matching(identifier: "feed-image-view").firstMatch
        XCTAssertTrue(firstCachedImage.exists)
    }
    
    // has no connectivity and no cache
    func test_onLaunch_displaysEmptyFeedWhenCustomerHasNoConnectivityAndNoCache() {
        let app = XCUIApplication()
        app.launchArguments = ["-reset", "-connectivity", "offline"]
        app.launch()
        
        let feedCells = app.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(feedCells.count, 0)
    }
}
 
*/
