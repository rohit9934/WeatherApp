//
//  WeatherAPINetworkManager.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation
import Combine
protocol NetworkService {
    func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, NetworkingError>
}

final class WeatherAPINetworkManager: NetworkService {
    private let session: URLSession
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, NetworkingError> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    guard httpResponse.statusCode == 200 else {
                        throw NetworkingError.invalidResponse(httpResponse.statusCode)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkingError in
                if let noInternetError = error as? URLError, noInternetError.code == .notConnectedToInternet {
                    return NetworkingError.noInternetConnection
                } else if let decodingError = error as? DecodingError {
                    return NetworkingError.decodingError((decodingError as NSError).localizedDescription)
                } else if case let NetworkingError.invalidResponse(statusCode) = error {
                    return NetworkingError.invalidResponse(statusCode)
                } else {
                    return NetworkingError.genericError(error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }

    
    
}


