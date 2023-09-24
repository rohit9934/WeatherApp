//
//  NetworkingLayerTests.swift
//  LearnSwiftUITests
//
//  Created by Rohit Sharma on 24/09/23.
//

import XCTest
import Combine
@testable import LearnSwiftUI
final class NetworkingLayerTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    func test_URLSessionWithSuccessResponse() {
        let data = mockData()
        let response = mockResponse(statusCode: 200)
        let exp = expectation(description: "Wait for request")
        
        MockURLSession.requestHandler = { _ in
            return (response, data)
        }
        
        makeSUT().fetchData(url: mockURL()).sink { completion in
            switch completion {
            case .failure(let error):
                // Handle the transformed error
                exp.fulfill()
                XCTAssertEqual(error, NetworkingError.invalidURL)
            case .finished:
                break
            }
        } receiveValue: { (data: WeatherInformationResponse) in
            exp.fulfill()
            print(data)
        }.store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        
    }
    
    func test_URLSessionWithInvalidResponse() {
        let data = mockData()
        let response = mockResponse(statusCode: 401)
        let exp = expectation(description: "Wait for request")
        
        MockURLSession.requestHandler = { _ in
            return (response, data)
        }
        makeSUT().fetchData(url: mockURL()).sink { completion in
            switch completion {
            case .failure(let error):
                // Handle the transformed error
                exp.fulfill()
                XCTAssertEqual(error, NetworkingError.invalidResponse(401))
            case .finished:
                break
            }
        } receiveValue: { (data: String) in
            exp.fulfill()
            print(data)
        }.store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        
    }
    
    func test_URLSessionWithDecodingError() {
        let data = mockData()
        let response = mockResponse(statusCode: 200)
        let exp = expectation(description: "Wait for request")
        let errorMessage = "The data couldn’t be read because it isn’t in the correct format."
        MockURLSession.requestHandler = { _ in
            return (response, data)
        }
        makeSUT().fetchData(url: mockURL()).sink { completion in
            switch completion {
            case .failure(let error):
                // Handle the transformed error
                exp.fulfill()
                print(error.errorMessage())
                XCTAssertEqual(error.errorMessage(), NetworkingError.decodingError(errorMessage).errorMessage())
                
            case .finished:
                break
            }
        } receiveValue: { (data: String) in
            exp.fulfill()
            print(data)
        }.store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        
    }
    
    func test_URLSessionWithInvalidURL() {
        let data = mockData()
        let response = mockResponse(statusCode: 200)
        let exp = expectation(description: "Wait for request")
        let errorMessage = "The data couldn’t be read because it isn’t in the correct format."
        MockURLSession.requestHandler = { _ in
            return (response, data)
        }
        makeSUT().fetchData(url: "").sink { completion in
            switch completion {
                case .failure(let error):
                    // Handle the transformed error
                exp.fulfill()
                XCTAssertEqual(error, NetworkingError.invalidURL)
                case .finished:
                    break
            }
        } receiveValue: { (data: WeatherInformationResponse) in
            print(data)
        }.store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
    }
    
   



    
    
    func makeSUT() -> NetworkService {
        let networkService: NetworkService
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLSession.self]
        let session = URLSession(configuration: config)
        networkService = WeatherAPINetworkManager(session: session)
        return networkService
    }
}
