//
//  SharedLocalizationTests.swift
//  EFeedTests
//
//  Created by Denis Yaremenko on 01.07.2025.
//

import XCTest
import EFeed

final class SharedLocalizationTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shared"
        let bundle = Bundle(for: LoadResourcePresenter<Any, DummyView>.self)
        assertLocalizedKeyAndValuesExist(bundle, table)
    }
    
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) { }
    }
}
