//
//  WeatherNetwork.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import Foundation

class WeatherNetwork {
    private let session: URLSession
    let api = WeatherAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    typealias WeatherNetworkResult = (Result<WeatherData, URLError>) -> ()
    func getWeather(by cityName: CityList, completion: @escaping WeatherNetworkResult) {
        guard let url = api.getWeather(by: cityName).url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(URLError(.unknown)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.zeroByteResource)))
                return
            }
            do {
                let hasData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(hasData))
                return
            } catch {
                completion(.failure(URLError(.cannotDecodeRawData)))
                return
            }
        }
    }
}
