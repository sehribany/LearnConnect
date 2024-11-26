//
//  CoreDataManager.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import CoreData

// MARK: - CoreDataManager
final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    // Persistent Container - Manages Core Data stack and persistent store.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Users")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // Saves changes in the context to the persistent store.
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
