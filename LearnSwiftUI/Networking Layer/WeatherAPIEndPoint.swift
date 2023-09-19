//
//  WeatherAPIEndPoint.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation


enum WeatherAPIEndPoint {
    case location(long: Double, lat: Double)
    
    
    func createWeatherURL(baseURL: URL) -> String? {
        switch self {
        case .location(long: let long, lat: let lat):
            var urlComponent = URLComponents()
            urlComponent.scheme = baseURL.scheme
            urlComponent.host = baseURL.host
            urlComponent.path = baseURL.path + "/data/2.5/weather"
            urlComponent.queryItems = [
                                URLQueryItem(name: "lat", value: String(lat)),
                                URLQueryItem(name: "lon", value: String(long)),
                                URLQueryItem(name: "units", value: "metric"),
                                URLQueryItem(name: "appid", value: Constants.apiKey)
                                
            ]
            return urlComponent.url?.absoluteString
        }
    }
}
