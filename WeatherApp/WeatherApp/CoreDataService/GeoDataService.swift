//
//  GeoDataService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 04.03.2024.
//

import Foundation
import CoreData


final class GeoDataService {
    static let shared = GeoDataService()
    private init() {}

    private let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GeoLocationModel")
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

    func deleteObject(object: GeoModel) {
        managedContext.delete(object)
    }
}
