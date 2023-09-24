//
//  WeatherAPIEndPoint.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation


enum WeatherAPIEndPoint {
    case location(userLocation: LocationDataModel)
    
    
    func createWeatherURL(baseURL: URL) -> String {
        switch self {
        case .location(let userLocation):
            var urlComponent = URLComponents()
            urlComponent.scheme = baseURL.scheme
            urlComponent.host = baseURL.host
            urlComponent.path = baseURL.path + "/data/2.5/weather"
            urlComponent.queryItems = [
                                URLQueryItem(name: "lat", value: String(userLocation.latitude)),
                                URLQueryItem(name: "lon", value: String(userLocation.longitude)),
                                URLQueryItem(name: "units", value: "metric"),
                                URLQueryItem(name: "appid", value: Constants.apiKey)
                                
            ]
            return (urlComponent.url?.absoluteString)!
        }
    }
}
