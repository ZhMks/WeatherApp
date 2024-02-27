//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 12.02.2024.
//

import Foundation

enum NetworkErrors: Error {
    case wrongURL
    case serverError
    case errorWithDataTask

    var description: String {
        switch self {
        case .wrongURL:
            return "Неверный URL"
        case .serverError:
            return "Ошибка сервера"
        case .errorWithDataTask:
            return "Ошибка создания таска"
        }
    }
}


protocol INetworkService {
    func fetchData(lat: String, lon: String, completion: @escaping (Result<NetworkServiceModel, NetworkErrors>) -> Void)
}

final class NetworkService: INetworkService {

    func fetchData(lat: String, lon: String, completion: @escaping (Result<NetworkServiceModel, NetworkErrors>) -> Void) {
        let headers = [ "X-Yandex-API-Key": "4bd7f22d-9199-40cc-ae2a-0bfe13a20973" ]
        let baseURL = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&lang=&limit=2&hours=true&extra=false"
        guard let fetchURL = URL.init(string: baseURL) else { return }
        var request = URLRequest(url: fetchURL)
       request.allHTTPHeaderFields = headers
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
