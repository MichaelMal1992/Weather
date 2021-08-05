//
//  currentHourlyWeatherCollectionViewCell.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit

class CurrentHourlyWeatherCollectionViewCell: UICollectionViewCell {

    static var identifier = String(describing: CurrentHourlyWeatherCollectionViewCell.self)
    @IBOutlet weak var currentConditionWeatherIconImageView: UIImageView!
    @IBOutlet weak var timeCurrentHourlyWeatherLabel: UILabel!
    @IBOutlet weak var temperatureCurrentHourlyWeatherLabel: UILabel!
    @IBOutlet weak var humidityCurrentHourlyWeatherLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
