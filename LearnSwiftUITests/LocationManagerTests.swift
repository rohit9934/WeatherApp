//
//  LocationManagerTests.swift
//  LearnSwiftUITests
//
//  Created by Rohit Sharma on 24/09/23.
//

import XCTest
import CoreLocation
@testable import LearnSwiftUI
final class LocationManagerTests: XCTestCase {
    
    func test_makeSUT() {
        let locationManager = LocationManager()
        XCTAssertNotNil(locationManager.locationManager.delegate)
        let clLocationManager = CLLocationManager()
        //32.73,latitude: 74.82
    //    clLocationManager.location = CLLocation(latitude: 32.73, longitude: 74.82)
        
        
        locationManager.locationManager(clLocationManager, didUpdateLocations: [CLLocation(latitude: 32.73, longitude: 74.82)])
    }
}
