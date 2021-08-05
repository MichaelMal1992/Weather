//
//  ListCities.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 16.07.21.
//

import Foundation

class ListCities: Decodable {
    
    let id: Int
    let name: String
    let state: String?
    let country: String
    let coord : Coordinate
}

class Coordinate: Decodable {
    let lon: Double
    let lat: Double
}
