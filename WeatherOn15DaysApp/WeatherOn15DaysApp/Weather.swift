//
//  Weather.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 16.07.21.
//

import Foundation

class Weather: Codable {

    let latitude: Double?
    let longitude: Double?
    let resolvedAddress: String?
    let address: String?
    let description: String?
    let days: [Days]?
    let currentConditions: CurrentWeather
}

class Days: Codable {

    let datetime: String?
    let tempmax: Double?
    let tempmin: Double?
    let humidity: Double?
    let windspeed: Double?
    let uvindex: Double?
    let conditions: String?
    let description: String?
    let icon: String?
    let hours: [Hours]?
}

class Hours: Codable {

    let datetime: String?
    let temp: Double?
    let humidity: Double?
    let windspeed: Double?
    let conditions: String?
    let icon: String?
}

class CurrentWeather: Codable {
    let datetime: String?
    let temp: Double?
    let feelslike: Double?
    let humidity: Double?
    let windspeed: Double?
    let pressure: Double?
    let visibility: Double?
    let uvindex: Double?
    let conditions: String?
    let icon: String?
    let sunrise: String?
    let sunset: String?
}
