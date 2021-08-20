//
//  WeatherViewPresenter.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 18.08.21.
//

import Foundation

class WeatherViewPresenter: WeatherViewPresenterProtocol {

    weak var weatherViewController: WeatherViewControllerProtocol?
    init(viewController: WeatherViewControllerProtocol) {
        self.weatherViewController = viewController
    }
    func viewDidLoad() {

    }

}
