//
//  CellController.swift
//  EFeediOS
//
//  Created by Denis Yaremenko on 04.07.2025.
//

import UIKit

// instead of using custom protocol CellController we use this typealias because we can get all of the
// required logic form these table view data source / delegate methods


/// #Option 1
//public typealias CellController = UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching


/// #Option 2
// delegate, prefetching - is not mandatory
//public typealias CellController = (
//    dataSource: UITableViewDataSource,
//    delegate: UITableViewDelegate?,
//    dataSourcePrefetching: UITableViewDataSourcePrefetching?
//)


/// #Option 3
// prefer a struct better because we can use different inits here
public struct CellController {
    // withoud id we cannot confirm to equatable or hasahble, so we need id
   /// AnyHashable — это тип-обертка, позволяющий хранить любые Hashable значения внутри себя. [42, "Hello", UUID()]
   /// Основное предназначение AnyHashable — работа с разными типами, соответствующими Hashable, в одной коллекции.

    let id: AnyHashable // когда необходимо работать с hashable но без привязки к конкретному типу
    let dataSource: UITableViewDataSource
    let delegate: UITableViewDelegate?
    let dataSourcePrefetching: UITableViewDataSourcePrefetching?
    
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource
        self.dataSourcePrefetching = dataSource
    }
    
    // second convenience init
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = nil
        self.dataSourcePrefetching = nil
    }
}

