//
//  CommentsUIComposer.swift
//  EApp
//
//  Created by Denis Yaremenko on 05.07.2025.
//

import UIKit
import Combine
import EFeed
import EFeediOS

public final class CommentsUIComposer {
    
    private init() {}
    
    private typealias CommentsPresentationAdapter = LoadResourcePresentationAdapter<[ImageComment], CommentsViewAdapter>

    public static func commentsComposedWith(commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Error>) -> ListViewController {
     
        let presentationAdapter = CommentsPresentationAdapter(
            loader: { commentsLoader() }
        )
        
        let commentsController = makeCommentsViewController(title: ImageCommentsPresenter.title)
        commentsController.onRefresh = presentationAdapter.loadResource
        
        let commentsViewAdapter = CommentsViewAdapter(controller: commentsController)

        let resourcePresenter = LoadResourcePresenter(
            resourceView: commentsViewAdapter,
            loadingView: WeakRefVirtualProxy(commentsController),
            errorView: WeakRefVirtualProxy(commentsController),
            mapper: { ImageCommentsPresenter.map($0) })
        
        presentationAdapter.presenter = resourcePresenter
        return commentsController
    }
    
    private static func makeCommentsViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.title = title
        return controller
    }
}
