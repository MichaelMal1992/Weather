//
//  ReversedGeolocation.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 19.07.21.
//

import UIKit
import CoreLocation

struct ReversedGeoLocation {
    let name: String            // eg. Apple Inc.
    let streetName: String      // eg. Infinite Loop
    let streetNumber: String    // eg. 1
    let city: String            // eg. Cupertino
    let state: String           // eg. CA
    let zipCode: String         // eg. 95014
    let country: String         // eg. United States
    let isoCountryCode: String  // eg. US

    init(with placemark: CLPlacemark) {
        self.name = placemark.name ?? ""
        self.streetName = placemark.thoroughfare ?? ""
        self.streetNumber = placemark.subThoroughfare ?? ""
        self.city = placemark.locality ?? ""
        self.state = placemark.administrativeArea ?? ""
        self.zipCode = placemark.postalCode ?? ""
        self.country = placemark.country ?? ""
        self.isoCountryCode = placemark.isoCountryCode ?? ""
    }
}
