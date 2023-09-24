//
//  WeatherViewModel.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation
import Combine


// This view model is one of the poorest classes i have written in a while
// Too many dependencies, need to follow facade to avoid Constructor over injection
// but i want to move to other things (80+) coverage is good.
final class WeatherViewModel: ObservableObject {
    private var weatherURL: String = ""
    let storageMechanism: PersistanceWeatherStorage = CoreDataStorage()
    @Published var isInternetPresent: Bool = false
    @Published var weatherInfo = BasicWeatherInfoDataModel()
    var locationManager = LocationManager()
    var internetConnectPresent: Bool = false
    var internetCheck = InternetPresenceService()
    init() {
        let locationDataModel = LocationDataModel(longitude: 32.73,latitude: 74.82, city: "Jammu")
        Constants.city = locationDataModel.city
        let url = WeatherAPIEndPoint.location(userLocation: locationDataModel).createWeatherURL(baseURL: Constants.baseURL)
        self.weatherURL = url
        self.retrieveData(internetConnectionPresent: internetConnectPresent)
    }
    
    func retrieveData(internetConnectionPresent: Bool) {
        let networkingFetchStrategy = NetworkRequestStrategy(weatherURL: self.weatherURL,persistantStorage: storageMechanism)
        let persistantFetchStrategy = PersistantStorageStrategy(persistantStorage: storageMechanism)
        
        let dataFetchStrategy = DataFetcher(dataFetchingStrategy: (internetConnectionPresent ? networkingFetchStrategy : persistantFetchStrategy))
        dataFetchStrategy.fetch { weatherData in
            self.weatherInfo = weatherData
        }
    }
}

