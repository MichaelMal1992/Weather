//
//  AllWeatherTableViewCell.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit

class AllWeatherTableViewCell: UITableViewCell {

    static var identifier = String(describing: AllWeatherTableViewCell.self)
    @IBOutlet weak var dateOfWeekLabel: UILabel!
    @IBOutlet weak var procentHumidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var maxAndMinTemperatureLabel: UILabel!
    @IBOutlet weak var conditionIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
