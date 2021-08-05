//
//  GeoLocation.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 19.07.21.
//

import Foundation

class GeoLocation: Codable {

    let display: String
    enum CodingKeys: String, CodingKey {
        case display = "display_name"
    }
}
