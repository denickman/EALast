//
//  FeedImageCellController.swift
//  EFeediOS
//
//  Created by Denis Yaremenko on 23.06.2025.
//

import UIKit
import EFeed

public protocol FeedImageCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

public final class FeedImageCellController {
    
    private let delegate: FeedImageCellControllerDelegate
    private var cell: FeedImageCell?
    
    public init(delegate: FeedImageCellControllerDelegate) {
        self.delegate = delegate
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        delegate.didRequestImage()
        return cell!
    }
    
    public func preload() {
        delegate.didRequestImage()
    }
    
    public func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }

    public func releaseCellForReuse() {
        cell?.onReuse = nil
        cell = nil
    }
}

extension FeedImageCellController: FeedImageView {
    public func display(_ viewModel: FeedImageViewModel<UIImage>) {
        cell?.locationContainer.isHidden = !viewModel.hasLocation
        cell?.locationLabel.text = viewModel.location
        cell?.descriptionLabel.text = viewModel.description
        
        cell?.feedImageView.setImageAnimated(viewModel.image)
        
        cell?.feedImageContainer.isShimmering = viewModel.isLoading
        cell?.feedImageRetryButton.isHidden = !viewModel.shouldRetry
        cell?.onRetry = delegate.didRequestImage
        
        cell?.onReuse = { [weak self] in
            self?.releaseCellForReuse()
        }
        
        /// accessibilityIdentifier for EssentialAppUIAcceptanceTests
        cell?.accessibilityIdentifier = "feed-image-cell"
        cell?.feedImageView.accessibilityIdentifier = "feed-image-view"
    }
}
