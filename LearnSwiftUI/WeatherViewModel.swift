//
//  WeatherViewModel.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation
import Network

final class WeatherViewModel: ObservableObject {
    private var weatherURL: String = ""
    @Published var weatherInfo = BasicWeatherInfoDataModel()
    init() {
        if let url = WeatherAPIEndPoint.location(long: 32.73, lat: 74.82).createWeatherURL(baseURL: Constants.baseURL) {
            self.weatherURL = url
        }
        self.retrieveData(internetConnectionPresent: false)
    }
    
    func retrieveData(internetConnectionPresent: Bool) {
        let networkingFetchStrategy = NetworkRequestStrategy(weatherURL: self.weatherURL)
        let persistantFetchStrategy = PersistantStorageStrategy(persistantStorage: UserDefaultsStorage())
        let dataFetchStrategy = DataFetcher(dataFetchingStrategy: (internetConnectionPresent ? networkingFetchStrategy : persistantFetchStrategy))
        dataFetchStrategy.fetch { weatherData in
            self.weatherInfo = weatherData
        }
    }
}

