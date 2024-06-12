//
//  GeoLocationService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 18.02.2024.
//

import Foundation

protocol ILocationService {
    func getLocationWith(string: String, completion: @escaping (Result<GeoLocationModel, NetworkErrors>) -> Void)
}



final class GeoLocationService: NSObject, ILocationService{

    private var geoModel = GeoLocationModel(lat: "", lon: "")
    var posValue: String = ""
    var currentElement: String = ""


    func getLocationWith(string: String, completion: @escaping (Result<GeoLocationModel, NetworkErrors>) -> Void) {

        let baseURL = "https://geocode-maps.yandex.ru/1.x/?apikey=8fcccd72-9032-4257-9d37-0b7cf966bcc8&geocode=\(string)&results=1"
        guard let fetchURL = URL.init(string: baseURL) else { return }
        var request = URLRequest(url: fetchURL)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkErrors.errorWithDataTask))
            }

            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        let parser = XMLParser(data: data)
                        parser.delegate = self
                        parser.parse()
                        completion(.success(self.geoModel))
                    }
                case 404:
                    completion(.failure(NetworkErrors.wrongURL))
                case 502:
                    completion(.failure(NetworkErrors.serverError))
                default: print("Error")
                }
            }
        }
        dataTask.resume()
    }

}

extension GeoLocationService: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "pos" {
           posValue = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        posValue += string
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "pos" {

            let coordinates = posValue.components(separatedBy: " ")

            let lon = coordinates[0]
            let lat = coordinates[1]
            
            geoModel.lat = lat
            geoModel.lon = lon
        }
    }

}
