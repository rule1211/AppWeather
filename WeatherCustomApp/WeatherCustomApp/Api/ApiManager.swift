//
//  ApiManager.swift
//  WeatherCustomApp
//
//  Created by Stefan Ruzic on 8.10.22..
//

import Foundation

class ApiManager {

    static let shared = ApiManager()

    private init() { }


    func fetchOpenWeatherApi(city: String, format: String, completion: @escaping (Result<OpenWeatherResponse, Error>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=51b1de9959a29560bb30dedccf0044c8&units=\(format)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let currentWeather = try jsonDecoder.decode(OpenWeatherResponse.self, from: data)
                    completion(.success(currentWeather))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
