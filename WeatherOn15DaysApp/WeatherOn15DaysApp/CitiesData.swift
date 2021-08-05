//
//  CitiesData.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 18.07.21.
//

import Foundation

class CitiesData: Decodable {
    let data: [Datas]
}

class Datas: Decodable {
    let country: String
    let cities: [String]
}
