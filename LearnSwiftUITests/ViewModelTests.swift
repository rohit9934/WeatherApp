//
//  ViewModelTests.swift
//  LearnSwiftUITests
//
//  Created by Rohit Sharma on 24/09/23.
//

import XCTest
@testable import LearnSwiftUI

final class ViewModelTests: XCTestCase {
    
    func test_makeSUT()  {
        let networkStrategy = NetworkRequestStrategy(weatherURL: mockURL(), networkService: makeSUT())
        let data = mockData()
        let response = mockResponse(statusCode: 200)
        MockURLSession.requestHandler = { _ in
            return (response, data)
        }
        let exp = XCTestExpectation(description: "Wait for fetch")
        networkStrategy.fetch { data in
            exp.fulfill()
            XCTAssertNotNil(data)
        }
        wait(for: [exp], timeout: 1)
    }
    func makeSUT() -> NetworkService {
        let networkService: NetworkService
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLSession.self]
        let session = URLSession(configuration: config)
        networkService = WeatherAPINetworkManager(session: session)
        return networkService
    }
    
    func testNetworkingEnum() {
        XCTAssertEqual("Server returned invalid response code. Expected between the range 200-299. Server returned 400", NetworkingError.invalidResponse(400).errorMessage())
        XCTAssertEqual("Please connect to Internet & try again.", NetworkingError.noInternetConnection.errorMessage())
        XCTAssertEqual("Some Message", NetworkingError.decodingError("Some Message").errorMessage())
        XCTAssertEqual("The URL is invalid, please enter the correct URL and try again", NetworkingError.invalidURL.errorMessage())
        XCTAssertEqual("Some Message", NetworkingError.genericError("Some Message").errorMessage())
        
        
        
        
        
    }
}
