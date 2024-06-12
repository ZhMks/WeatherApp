//
//  GeoDataModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 04.03.2024.
//

import Foundation


final class GeoDataModelService {

    private(set) var modelArray: [GeoModel]?
    let coreDataService = GeoDataService.shared



    init()
    {
        fetchFromCoreData()
    }


    private func fetchFromCoreData() {
        let request = GeoModel.fetchRequest()
        do {
            modelArray = try coreDataService.managedContext.fetch(request)
        } catch {
            modelArray = []
            print("Cannot fetch data from CoreData modelsArray = []")
        }
    }

    func saveModelToCoreData(lat: String, lon: String) {

        guard let modelArray = modelArray else { return }

        if modelArray.isEmpty {
            let modelToSave = GeoModel(context: GeoDataService.shared.managedContext)
            modelToSave.lat = lat
            modelToSave.lon = lon

            coreDataService.saveContext()
            fetchFromCoreData()
        }

        for model in modelArray {
            if model.lat == lat && model.lon == lon {
                return
            } else {
                let modelToSave = GeoModel(context: GeoDataService.shared.managedContext)
                modelToSave.lat = lat
                modelToSave.lon = lon

                coreDataService.saveContext()
                fetchFromCoreData()
            }
        }
    }

    func deleteModel() {
        if let modelsArray = modelArray {
            for model in modelsArray {
                coreDataService.deleteObject(object: model)
                coreDataService.saveContext()
            }
        }
        fetchFromCoreData()
    }
}
