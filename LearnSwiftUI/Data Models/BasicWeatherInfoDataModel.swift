//
//  BasicWeatherInfoDataModel.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

struct BasicWeatherInfoDataModel: Codable {
    var conditon: String = ""
    var description: String = ""
    var temperature: Double = 0.0
    var tempMin: Double = 0.0
    var tempMax: Double = 0.0
    var weatherIcon: String = ""
    init() {}
    init(response: WeatherInformationResponse){
        self.conditon = response.weather.first?.main ?? ""
        self.description = response.weather.first?.description ?? ""
        self.temperature = response.main.temp
        self.tempMin = response.main.tempMin
        self.tempMax = response.main.tempMax
        self.weatherIcon = response.weather.first?.icon ?? ""
    }
}
