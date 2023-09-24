//
//  CoreDataStorage.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 19/09/23.
//

import Foundation
import CoreData
class CoreDataStorage: PersistanceWeatherStorage {
    let container: NSPersistentContainer
    var savedWeather: [WeatherInformationEntity] = []
    init() {
        container = NSPersistentContainer(name: "WeatherInfoModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            } else {
                print("Successfully loaded")
            }
        }
    }
    
    func save(weatherInformation: BasicWeatherInfoDataModel) {
        let weather = WeatherInformationEntity(context: container.viewContext)
        weather.weatherCondition = weatherInformation.conditon
        weather.weatherDescription = weatherInformation.description
        weather.temperature = weatherInformation.temperature
        weather.humidity = Int16(weatherInformation.humidity)
        weather.visibility = Int16(weatherInformation.visibility)
        weather.speed = weatherInformation.wind_speed
        weather.city = weatherInformation.city
        do {
            try container.viewContext.save()
        } catch let erro {
            print(erro)
        }
    }
    
    func delete() {
        
    }
    
    func retrieve() -> BasicWeatherInfoDataModel {
        var weatherData = BasicWeatherInfoDataModel()
        let weather = NSFetchRequest<WeatherInformationEntity>(entityName: "WeatherInformationEntity")
        do {
            savedWeather = try container.viewContext.fetch(weather)
            if let weather = savedWeather.last {
                weatherData = BasicWeatherInfoDataModel(weatherEntity: weather)
            }
        }catch let error {
            print(error)
        }
        return weatherData
    }
    
    
}
