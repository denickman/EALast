//
//  UIRefreshControl+Ext.swift
//  EFiOSM
//
//  Created by Denis Yaremenko on 12.02.2025.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
