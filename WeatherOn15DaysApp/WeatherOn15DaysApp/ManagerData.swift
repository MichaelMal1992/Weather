//
//  ManagerCities.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 16.07.21.
//

import Foundation

class ManagerData {

    static var shared = ManagerData()
    var currentCity = ""
    var weather: Weather?
    var citiesStringArray: [String] = []
    var sortedCitiesStringArray: [String] = []
    var nameCity = ""
    var isChangeCity = false
    var isGeoLocationDidUpdate = false
    var geoLocationResponse = ""
}
