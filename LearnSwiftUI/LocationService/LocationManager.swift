//
//  LocationManager.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    //locations = 32.73046875 74.82595999609072
    let locationManager = CLLocationManager()
    var userLocation = LocationDataModel()
    override init() {
        super.init()
        locationManager.delegate = self
    }
    func getLocation() {
        locationManagerDidChangeAuthorization(locationManager)
        locationManager(locationManager, didUpdateLocations: [])
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue:CLLocationCoordinate2D = manager.location?.coordinate {
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.userLocation.latitude = locValue.latitude
            self.userLocation.longitude = locValue.longitude
        }
        let userLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                return
            }
            if let city = placemarks?.first?.locality {
                print("User's City: \(city)")
            }
        }
        
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
