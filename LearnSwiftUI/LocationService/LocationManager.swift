//
//  LocationManager.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//


import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    //locations = 32.73046875 74.82595999609072
    let locationManager = CLLocationManager()
    var userLocation = LocationDataModel()
    var locationSubject = PassthroughSubject<LocationDataModel, Never> ()
    var cancellables = Set<AnyCancellable>()
    override init() {
        super.init()
        locationManager.delegate = self
        getLocation()
    }
    func getLocation() {
        locationManagerDidChangeAuthorization(locationManager)
        locationManager(locationManager, didUpdateLocations: [])
        
        locationSubject.sink { locationModel in
            print(locationModel)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.userLocation.latitude == 0.0 {
            if let locValue:CLLocationCoordinate2D = manager.location?.coordinate {
                print("locations = \(locValue.latitude) \(locValue.longitude)")
                self.userLocation.latitude = locValue.latitude
                self.userLocation.longitude = locValue.longitude
            }
            let userLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(userLocation) { [weak self] placemarks, error in
                guard let self = self else {return}
                if let error = error {
                    print("Reverse geocoding failed: \(error.localizedDescription)")
                    return
                }
                if let city = placemarks?.first?.locality {
                    self.userLocation.city = city
                    Constants.city = city
                    print(city)
                    self.locationManager.stopUpdatingLocation()
                    self.locationSubject.send(self.userLocation)
                    return
                }
            }
            self.locationSubject.send(self.userLocation)
            
            locationManager.stopUpdatingLocation()
        }
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
