//
//  BasicWeatherInfoDataModel.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

struct BasicWeatherInfoDataModel: Codable, Equatable {
    var conditon: String = ""
    var description: String = ""
    var temperature: Double = 0.0
    var humidity: Int = 0
    var visibility: Int = 0
    var wind_speed: Double = 0.0
    var city: String = ""
    init() {}
    init(response: WeatherInformationResponse){
        self.conditon = response.weather.first?.main ?? ""
        self.description = response.weather.first?.description ?? ""
        self.temperature = response.main.temp
        self.humidity = response.main.humidity
        self.visibility = response.visibility
        self.wind_speed = response.wind.speed
        self.city = Constants.city
    }
    init(weatherEntity: WeatherInformationEntity){
        self.conditon = weatherEntity.weatherCondition ?? ""
        self.description = weatherEntity.weatherDescription ?? ""
        self.temperature = weatherEntity.temperature
        self.humidity = Int(weatherEntity.humidity)
        self.visibility = Int(weatherEntity.visibility)
        self.wind_speed = weatherEntity.speed
        self.city = weatherEntity.city ?? ""
    }
}
