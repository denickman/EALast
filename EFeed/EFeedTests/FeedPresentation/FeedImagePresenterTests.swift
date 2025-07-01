//
//  FeedImagePresenterTests.swift
//  EFeedTests
//
//  Created by Denis Yaremenko on 30.06.2025.
//

import XCTest
import EFeed

final class FeedImagePresenterTests: XCTestCase {

    func test_map_createsViewModel() {
        let image = uniqueImage()
        
        let viewModel = FeedImagePresenter.map(image)

        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.location, image.location)
    }
}
