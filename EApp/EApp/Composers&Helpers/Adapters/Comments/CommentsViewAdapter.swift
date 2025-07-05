//
//  CommentsViewAdapter.swift
//  EApp
//
//  Created by Denis Yaremenko on 05.07.2025.
//

import Foundation
import EFeed
import EFeediOS

final class CommentsViewAdapter: ResourceView {
    
    private weak var controller: ListViewController?
    
    init(controller: ListViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: ImageCommentsViewModel) {
        controller?.display(viewModel.comments.map { viewModel in
            CellController(id: viewModel, ImageCommentCellController(model: viewModel))
        })
    }
}
