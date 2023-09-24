//
//  NetworkRequestStrategy.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation
import Combine
protocol DataFetchingStrategy {
    func fetch(completion: @escaping(BasicWeatherInfoDataModel) -> Void)
}

final class NetworkRequestStrategy: DataFetchingStrategy{
    var networkService : NetworkService
    var weatherURL: String
    private var persistantStorage: PersistanceWeatherStorage
    private var cancellables = Set<AnyCancellable>()
    init(weatherURL: String,
         networkService: NetworkService = WeatherAPINetworkManager(),
         persistantStorage: PersistanceWeatherStorage = CoreDataStorage()){
        self.networkService = networkService
        self.weatherURL = weatherURL
        self.persistantStorage = persistantStorage
    }
    
    func fetch(completion: @escaping(BasicWeatherInfoDataModel) -> Void){
        networkService.fetchData(url: weatherURL)
         //   .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: {  (data: WeatherInformationResponse) in
                var weatherInfo = BasicWeatherInfoDataModel(response: data)
                weatherInfo.city = Constants.city
                self.persistantStorage.save(weatherInformation: weatherInfo)
                completion(weatherInfo)
            }.store(in: &cancellables)
    }
    
}

final class PersistantStorageStrategy: DataFetchingStrategy {
    private var persistantStorage: PersistanceWeatherStorage
    internal init(persistantStorage: PersistanceWeatherStorage) {
        self.persistantStorage = persistantStorage
    }
    func fetch(completion: @escaping (BasicWeatherInfoDataModel) -> Void) {
        completion(persistantStorage.retrieve())
    }
}

final class DataFetcher {
    var dataFetchingStrategy: DataFetchingStrategy
    internal init(dataFetchingStrategy: DataFetchingStrategy) {
        self.dataFetchingStrategy = dataFetchingStrategy
    }
    func fetch(completion: @escaping (BasicWeatherInfoDataModel) -> Void) {
        dataFetchingStrategy.fetch(completion: completion)
    }
}
