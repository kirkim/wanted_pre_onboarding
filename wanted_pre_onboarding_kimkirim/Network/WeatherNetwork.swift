//
//  WeatherNetwork.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import UIKit

class WeatherNetwork {
    static let shared = WeatherNetwork()
    private let session: URLSession
    private let api = WeatherAPI()

    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    typealias WeatherNetworkResult = (Result<WeatherData, URLError>) -> ()
    func getWeather(by cityName: CityList, completion: @escaping WeatherNetworkResult) {
        print("WeatherNetwork getWeather() called!")
        DispatchQueue.global().async { [weak self] in
            guard let url = self?.api.getWeather(by: cityName).url else {
                completion(.failure(URLError(.badURL)))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            self?.session.dataTask(with: request) { data, response, error in
                guard let data = self?.errorHandler(data: data, response: response, error: error, completion: completion) else { return }
                
                do {
                    let hasData = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(hasData))
                    }
                    return
                } catch {
                    completion(.failure(URLError(.cannotDecodeRawData)))
                    return
                }
            }.resume()
        }
    }
    
    typealias IconNetworkResult = (Result<UIImage, URLError>) -> ()
    func getIconImage(by code: String, completion: @escaping IconNetworkResult) {
        DispatchQueue.global().async { [weak self] in

            let urlString = self?.api.getWeatherIcon(by: code)
            let cachedImage = ImageCacheManager.shared.getCachedImage(urlString: urlString!)
            if (cachedImage != nil) {
                DispatchQueue.main.async {
                    completion(.success(cachedImage!))
                }
                return
            }

            guard let url = URL(string: urlString!) else {
                completion(.failure(URLError(.badURL)))
                return
            }
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!) ?? UIImage()
            ImageCacheManager.shared.setObject(image: image, urlString: urlString!)
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
    }
    
    private func errorHandler<T>(data: Data?, response: URLResponse?, error: Error?, completion: (Result<T, URLError>) -> ()) -> Data? {
        if let error = error {
            print(error)
            completion(.failure(URLError(.unknown)))
            return nil
        }
        
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            completion(.failure(URLError(.badServerResponse)))
            return nil
        }
        
        guard let data = data else {
            completion(.failure(URLError(.zeroByteResource)))
            return nil
        }
        return data
    }
}
