//
//  LoadResourcePresenter.swift
//  EFeed
//
//  Created by Denis Yaremenko on 01.07.2025.
//

import Foundation

public protocol ResourceView {
    associatedtype ResourceViewModel
    func display(_ viewModel: ResourceViewModel)
}

public final class LoadResourcePresenter<Resource, View: ResourceView> {
    
    public typealias Mapper = (Resource) -> View.ResourceViewModel
    
    public static var loadError: String {
        NSLocalizedString(
            "GENERIC_CONNECTION_ERROR",
            tableName: "Shared", bundle: Bundle(for: Self.self),
            comment: "Error message displayed when we can't load the resource from the server"
        )
    }
    
    private let resourceView: View
    private let loadingView: ResourceLoadingView
    private let errorView: ResourceErrorView
    private let mapper: Mapper
    
    public init(
        resourceView: View,
        loadingView: ResourceLoadingView,
        errorView: ResourceErrorView,
        mapper: @escaping Mapper
    ) {
        self.resourceView = resourceView
        self.loadingView = loadingView
        self.errorView = errorView
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(.init(isLoading: true))
    }
    
    public func didFinishLoading(with resource: Resource) {
        resourceView.display(mapper(resource))
        loadingView.display(.init(isLoading: false))
    }
    
    public func didFinishLoading(with error: Error) {
        errorView.display(.error(message: Self.loadError))
        loadingView.display(.init(isLoading: false))
    }
}
