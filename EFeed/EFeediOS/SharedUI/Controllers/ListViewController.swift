//
//  FeedViewController.swift
//  EFeediOS
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import UIKit
import EFeed

public final class ListViewController: UITableViewController {
    
    private(set) public var errorView = ErrorView()
    
    private var loadingControllers = [IndexPath: CellController]()
    
    public var onRefresh: (() -> Void)?
    
    private var tableModel = [CellController]() {
        didSet { tableView.reloadData() }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureErrorView()
        refresh()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.sizeTableHeaderToFit()
    }
    
    public func display(_ cellControllers: [CellController]) {
        loadingControllers = [:]
        tableModel = cellControllers
    }
    
    @IBAction private func refresh() {
        onRefresh?()
    }
    
    private func configureErrorView() {
        let container = UIView()
        container.backgroundColor = .clear
        container.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            errorView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: container.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        tableView.tableHeaderView = container
        
        errorView.onHide = { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.sizeTableHeaderToFit()
            self?.tableView.endUpdates()
        }
    }
}

extension ListViewController: UITableViewDataSourcePrefetching {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ds = cellController(forRowAt: indexPath).dataSource
        return ds.tableView(tableView, cellForRowAt: indexPath)
    }
    
    /// Когда вы вызываете `tableView.reloadData()`, это приводит к повторной загрузке данных в таблице, что включает перерасчет всех видимых ячеек и обновление их на экране. Однако, перед тем как обновить эти ячейки, система вызывает метод делегата `tableView(_:didEndDisplaying:forRowAt:)` для каждой ячейки, которая больше не отображается на экране.
    
    /// When updating the table model and reloading the table, UIKit calls `didEndDisplayingCell` for each removed cell that was previously visible. Since we're canceling requests in this method, we could be sending messages to the new models or potentially crashing in case the new table model has fewer items than the previous one!
    
    /// This is not a big problem at the moment since items cannot be removed from the feed. But we cannot assume the backend will keep this behavior going further.
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let delegate = removeLoadingController(forRowAt: indexPath)?.delegate
        delegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let pds = cellController(forRowAt: indexPath).dataSourcePrefetching
            pds?.tableView(tableView, prefetchRowsAt: [indexPath])
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let pds = cellController(forRowAt: indexPath).dataSourcePrefetching
            pds?.tableView?(tableView, cancelPrefetchingForRowsAt: [indexPath])
        }
    }
    
    public func cellController(forRowAt indexPath: IndexPath) -> CellController {
        let controller = tableModel[indexPath.row]
        loadingControllers[indexPath] = controller
        return controller
    }
    
    public func removeLoadingController(forRowAt indexPath: IndexPath) -> CellController? {
        let ctrl = loadingControllers[indexPath]
        loadingControllers[indexPath] = nil
        return ctrl
    }
}

extension ListViewController: ResourceLoadingView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        refreshControl?.update(isRefreshing: viewModel.isLoading)
    }
}

extension ListViewController: ResourceErrorView {
    public func display(_ viewModel: ResourceErrorViewModel) {
        errorView.message = viewModel.message
    }
}
