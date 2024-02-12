//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 12.02.2024.
//

import Foundation


protocol INetworkService {
    func fetchData(lat: CGFloat, lon: CGFloat, completion: @escaping (Result<NetworkServiceModel, Error>) -> Void)
}

final class NetworkService: INetworkService {

    func fetchData(lat: CGFloat, lon: CGFloat, completion: @escaping (Result<NetworkServiceModel, Error>) -> Void) {
        let headers = [ "X-Yandex-API-Key": "4bd7f22d-9199-40cc-ae2a-0bfe13a20973" ]
        let baseURL = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&lang=ru_RU"
        guard let fetchURL = URL.init(string: baseURL) else { return }
        var request = URLRequest(url: fetchURL)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }

            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                        let decoder = JSONDecoder()
                        do {
                            let networkData = try decoder.decode(NetworkServiceModel.self, from: data)
                            completion(.success(networkData))
                        } catch let DecodingError.dataCorrupted(context) {
                            print(context)
                        } catch let DecodingError.keyNotFound(key, context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.valueNotFound(value, context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.typeMismatch(type, context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch {
                            print("error: ", error)
                        }
                    }
                case 404:
                    print("Error.404")
                case 502:
                    print("Error.502")
                default: print("Error")
                }
            }
        }
        dataTask.resume()
    }
}
