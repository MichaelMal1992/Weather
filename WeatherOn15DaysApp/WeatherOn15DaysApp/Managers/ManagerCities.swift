//
//  ManagerCities.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 16.07.21.
//

import Foundation

class ManagerCities {

    static var shared = ManagerCities()

    var currentCity = ""
    var weather: WeatherData?
    var nameCity = ""
    var isChangeCity = false
    var isGeoLocationDidUpdate = false
    var geoLocationResponse = ""
}
