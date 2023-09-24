//
//  MockURLSession.swift
//  LearnSwiftUITests
//
//  Created by Rohit Sharma on 24/09/23.
//

import XCTest

class MockURLSession: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse?, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLSession.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            if let response = response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
    }
}


// other types of Mocks Needed to test URLSession

func mockURL() -> String {
    return "https://mockURL.com"
}

func mockData() -> Data {
    return """
            {
                "coord": {
                    "lon": 32.73,
                    "lat": 74.82
                },
                "weather": [
                    {
                        "id": 804,
                        "main": "Clouds",
                        "description": "overcast clouds",
                        "icon": "04d"
                    }
                ],
                "base": "stations",
                "main": {
                    "temp": 3.93,
                    "feels_like": -2.83,
                    "temp_min": 3.93,
                    "temp_max": 3.93,
                    "pressure": 1005,
                    "humidity": 71,
                    "sea_level": 1005,
                    "grnd_level": 1005
                },
                "visibility": 10000,
                "wind": {
                    "speed": 14.2,
                    "deg": 54,
                    "gust": 15.12
                },
                "clouds": {
                    "all": 100
                },
                "dt": 1695120697,
                "sys": {
                    "sunrise": 1695092767,
                    "sunset": 1695140409
                },
                "timezone": 7200,
                "id": 0,
                "name": "",
                "cod": 200
            }
           """.data(using: .utf8)!
}

func mockResponse(statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(statusCode: statusCode)
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        let url = URL(string: mockURL())!
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
