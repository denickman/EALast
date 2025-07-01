//
//  ImageCommentsLocalizationTests.swift
//  EFeedTests
//
//  Created by Denis Yaremenko on 01.07.2025.
//

import XCTest
import EFeed

final class ImageCommentsLocalizationTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "ImageComments"
        let bundle = Bundle(for: ImageCommentsPresenter.self)
        assertLocalizedKeyAndValuesExist(bundle, table)
    }

}
