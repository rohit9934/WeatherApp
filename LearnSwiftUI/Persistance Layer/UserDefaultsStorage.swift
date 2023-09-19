//
//  PersistanceStorage.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation

protocol PersistanceWeatherStorage {
    func save(weatherInformation: BasicWeatherInfoDataModel)
    func delete()
    func retrieve() -> BasicWeatherInfoDataModel
}


class UserDefaultsStorage: PersistanceWeatherStorage {
    let userDefaultKey = "WeatherInformation"

    
    func save(weatherInformation: BasicWeatherInfoDataModel) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(weatherInformation) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultKey)
        }
    }
    
    func delete() {
        
    }
    
    func retrieve() -> BasicWeatherInfoDataModel {
        var weatherInformation = BasicWeatherInfoDataModel()
        let decoder = JSONDecoder()
        if let weatherInfo = UserDefaults.standard.data(forKey: userDefaultKey) , let decodedData = try? decoder.decode(BasicWeatherInfoDataModel.self, from: weatherInfo) {
            weatherInformation = decodedData
        }
        return weatherInformation
    }
    
    
}
