//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Denis Yaremenko on 30.01.2025.
//

import CoreData

public final class CoreDataFeedStore {
    private static let modelName = "FeedStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataFeedStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }

    public init(storeURL: URL) throws {
        guard let model = CoreDataFeedStore.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataFeedStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }

    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        /// Обеспечивает безопасность потоков, так как NSManagedObjectContext нельзя использовать в другом потоке напрямую
        ///  Избегает блокировок основного потока, так как все операции выполняются в фоновом контексте
        /// Этот метод выполняет переданный блок асинхронно, т.е. код будет выполняться в контексте соответствующей очереди (например, в фоне, если это фоновой контекст). Это аналог асинхронного вызова, потому что блок будет выполнен в фоновом потоке, а выполнение метода продолжится сразу, не дожидаясь завершения операции.
        let context = self.context
        context.perform { action(context) }
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}
