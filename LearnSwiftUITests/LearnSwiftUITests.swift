//
//  LearnSwiftUITests.swift
//  LearnSwiftUITests
//
//  Created by Rohit Sharma on 28/03/23.
//

import XCTest
import Combine
@testable import LearnSwiftUI

final class LearnSwiftUITests: XCTestCase {

    func test_UserDefault() {
        
        // Given i have a weather
        let userDefaults = UserDefaultsStorage()
        var weatherInfo = BasicWeatherInfoDataModel()
        weatherInfo.conditon = "Sunny"
        weatherInfo.description = "It's very Sunny"
        weatherInfo.temperature = 5.0
        weatherInfo.humidity = 12
        weatherInfo.visibility = 15
        weatherInfo.wind_speed = 40
        weatherInfo.city = "Kashmir"
        
        // When i save The weather
        userDefaults.save(weatherInformation: weatherInfo)
        
        // Then Same Weather should be retrieved when i call retrieve.
        let myWeatherInfo = userDefaults.retrieve()
        XCTAssertEqual(myWeatherInfo, weatherInfo)
    }
    
    func test_CoreDataStorage() {
        // Given i have a weather
        let coreData = CoreDataStorage()
        var weatherInfo = BasicWeatherInfoDataModel()
        weatherInfo.conditon = "Sunny"
        weatherInfo.description = "It's very Sunny"
        weatherInfo.temperature = 5.0
        weatherInfo.humidity = 12
        weatherInfo.visibility = 15
        weatherInfo.wind_speed = 40
        weatherInfo.city = "Kashmir"
        
        // When i save The weather
        coreData.save(weatherInformation: weatherInfo)
        
        // Then Same Weather should be retrieved when i call retrieve.
        let myWeatherInfo = coreData.retrieve()
        XCTAssertEqual(myWeatherInfo, weatherInfo)
    }
    
    
    
    func test_NetworkingCallWithValidURL() {
        
    }
}
