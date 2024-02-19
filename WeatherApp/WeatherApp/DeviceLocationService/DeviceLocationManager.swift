//
//  DeviceLocationManager.swift
//  WeatherApp
//
//  Created by Максим Жуин on 18.02.2024.
//

import Foundation
import CoreLocation

final class DeviceLocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = DeviceLocationManager()

    var lon: CLLocationDegrees = 0.0
    var lat: CLLocationDegrees = 0.0
    var authorisation: Bool = false

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first?.coordinate else { return }

        self.lat = location.latitude
        self.lon = location.longitude
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            break
        case .restricted:
            manager.stopUpdatingLocation()
        case .denied:
            manager.stopUpdatingLocation()
        case .authorizedAlways:
            self.authorisation = true

        case .authorizedWhenInUse:
            self.authorisation = true

        case .authorized:
            self.authorisation = true

        @unknown default:
            assertionFailure("Error in locationManager")
        }
    }

}
