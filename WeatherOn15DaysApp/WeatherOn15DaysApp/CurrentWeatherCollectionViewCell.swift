//
//  currentHourlyWeatherCollectionViewCell.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {

    static var identifier = String(describing: CurrentWeatherCollectionViewCell.self)
    @IBOutlet weak var currentConditionImageView: UIImageView!
    @IBOutlet weak var timeCurentLabel: UILabel!
    @IBOutlet weak var temperatureCurentLabel: UILabel!
    @IBOutlet weak var humidityCurentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
