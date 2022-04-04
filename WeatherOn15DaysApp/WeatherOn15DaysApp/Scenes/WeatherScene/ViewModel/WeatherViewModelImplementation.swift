//
//  WeatherViewPresenter.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 18.08.21.
//

import Foundation

class WeatherViewModelImplementation: WeatherViewModal {

    weak var viewController: WeatherViewController?

    init(_ viewController: WeatherViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {

    }

}
