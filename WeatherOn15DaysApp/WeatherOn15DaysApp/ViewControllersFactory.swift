//
//  ViewControllersFactory.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 18.08.21.
//

import UIKit

class ViewcontrollerFactory {

    static func createCitiesViewController() -> CitiesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: String(describing: CitiesViewController.self)) as? CitiesViewController else {
            return CitiesViewController()
        }
//        let presenter = CitiesViewPresenter(viewController: viewController)
//        viewController.presenter = presenter
        return viewController
    }

//    static func createWeatherViewController() -> WeatherViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let viewController = storyboard.instantiateViewController(identifier: String(describing: WeatherViewController.self)) as? WeatherViewController else {
//            return CitiesViewController()
//        }
//        let presenter = CitiesViewPresenter(viewController: viewController)
//        presenter.citiesViewController = viewController
//        return viewController
//    }
}
