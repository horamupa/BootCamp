//
//  CoreDataManager2.swift
//  BootCamp
//
//  Created by MM on 19.06.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let persistenceContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        persistenceContainer.viewContext
    }
    private init() {
        // Choosing the Entity to work with
        persistenceContainer = NSPersistentContainer(name: "MeditationsDataModel")
        // Auto merge changed content from CoreData
        // View context is state of all data our app is working with and we can save it
        persistenceContainer.viewContext.automaticallyMergesChangesFromParent = true
        // Actually load the persistence file
        persistenceContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load the persistence from CoreData \(error )")
            }
        }
    }
    
}
