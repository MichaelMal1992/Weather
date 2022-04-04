//
//  CitiesData.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 18.07.21.
//

import Foundation

class CitiesData: Codable {
    let data: [InfoData]
}

class InfoData: Codable {
    let country: String
    let cities: [String]
}
