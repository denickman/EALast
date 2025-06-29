//
//  CodableFeedStoreTests.swift
//  EFeedTests
//
//  Created by Denis Yaremenko on 23.06.2025.
//

import XCTest
import EFeed

/*
 
 class CodableFeedStoreTests: XCTestCase, FailableFeedStoreSpecs {
 
 func test_delete_deliversErrorOnDeletionError() {
 
 }
 
 func test_insert_deliversNoErrorOnEmptyCache() {
 
 }
 
 func test_insert_deliversNoErrorOnNonEmptyCache() {
 
 }
 
 
 override func setUp() {
 super.setUp()
 setupEmptyStoreState()
 }
 
 override func tearDown() {
 super.tearDown()
 undoStoreSideEffects()
 }
 
 func test_retrieve_deliversEmptyOnEmptyCache() {
 let sut = makeSUT()
 assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
 }
 
 func test_retrieve_hasNoSideEffectsOnEmptyCache() {
 let sut = makeSUT()
 assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
 }
 
 func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
 let sut = makeSUT()
 assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
 }
 
 func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
 let sut = makeSUT()
 assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
 }
 
 //    func test_insert_deliversNoErrorOnEmptyCache() {
 //        let sut = makeSUT()
 //        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
 //    }
 //
 //    func test_insert_deliversNoErrorOnNonEmptyCache() {
 //        let sut = makeSUT()
 //        assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
 //    }
 
 func test_insert_overridesPreviouslyInsertedCacheValues() {
 let sut = makeSUT()
 assertThatInsertOverridesPreviouslyInsertedCacheValues(on: sut)
 }
 
 func test_insert_deliversErrorOnInsertionError() {
 let invalidStoreURL = URL(string: "invalid://store-url")!
 let sut = makeSUT(storeURL: invalidStoreURL)
 assertThatInsertDeliversErrorOnInsertionError(on: sut)
 }
 
 func test_insert_hasNoSideEffectsOnInsertionError() {
 let invalidStoreURL = URL(string: "invalid://store-url")!
 let sut = makeSUT(storeURL: invalidStoreURL)
 
 assertThatInsertHasNoSideEffectsOnInsertionError(on: sut)
 }
 
 func test_delete_deliversNoErrorOnEmptyCache() {
 let sut = makeSUT()
 assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
 }
 
 func test_delete_hasNoSideEffectsOnEmptyCache() {
 let sut = makeSUT()
 assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
 }
 
 func test_delete_deliversNoErrorOnNonEmptyCache() {
 let sut = makeSUT()
 assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
 }
 
 func test_delete_emptiesPreviouslyInsertedCache() {
 let sut = makeSUT()
 assertThatDeleteEmptiesPreviouslyInsertedCache(on: sut)
 }
 
 //    func test_delete_deliversErrorOnDeletionError() {
 //        let noDeletePermissionURL = cachesDirectory()
 //        let sut = makeSUT(storeURL: noDeletePermissionURL)
 //        assertThatDeleteDeliversErrorOnDeletionError(on: sut)
 //    }
 
 func test_delete_hasNoSideEffectsOnDeletionError() {
 let noDeletePermissionURL = cachesDirectory()
 let sut = makeSUT(storeURL: noDeletePermissionURL)
 
 assertThatDeleteHasNoSideEffectsOnDeletionError(on: sut)
 }
 
 func test_storeSideEffects_runSerially() {
 let sut = makeSUT()
 assertThatSideEffectsRunSerially(on: sut)
 }
 
 func test_retrieve_deliversFailureOnRetrievalError() {
 let storeURL = testSpecificStoreURL()
 let sut = makeSUT(storeURL: storeURL)
 try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
 assertThatRetrieveDeliversFailureOnRetrievalError(on: sut)
 }
 
 func test_retrieve_hasNoSideEffectsOnFailure() {
 let storeURL = testSpecificStoreURL()
 let sut = makeSUT(storeURL: storeURL)
 try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
 assertThatRetrieveHasNoSideEffectsOnFailure(on: sut)
 }
 
 // MARK: - Helpers
 
 func makeSUT(storeURL: URL? = nil, file: StaticString = #filePath, line: UInt = #line) -> FeedStore {
 let sut = CodableFeedStore(storeURL: storeURL ?? testSpecificStoreURL())
 trackForMemoryLeaks(sut, file: file, line: line)
 return sut
 }
 
 private func testSpecificStoreURL() -> URL {
 return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
 }
 
 private func cachesDirectory() -> URL {
 FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
 }
 
 private func setupEmptyStoreState() {
 deleteStoreArtifacts()
 }
 
 private func undoStoreSideEffects() {
 deleteStoreArtifacts()
 }
 
 func deleteStoreArtifacts() {
 try? FileManager.default.removeItem(at: testSpecificStoreURL())
 }
 }
 
 
 */
