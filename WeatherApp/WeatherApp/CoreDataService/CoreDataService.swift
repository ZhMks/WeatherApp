//
//  CoreDataService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 13.02.2024.
//

import Foundation
import CoreData


final class CoreDataService {
    
    static let shared = CoreDataService()
    private init() {}

    private let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ForecastsModels")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = {
        return persistantContainer.viewContext
    }()

    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

