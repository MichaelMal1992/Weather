//
//  CitiesViewPresenter.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 18.08.21.
//

import Foundation
import UIKit

class CitiesViewModelImplementation: CitiesViewModel {

    weak var viewController: CitiesViewController?
    init(_ viewController: CitiesViewController) {
        self.viewController = viewController
    }

    var didUpdateData: (([String]) -> Void)?

    private var cities: [String]? {
        didSet {
            if let citiesData = cities {
                self.didUpdateData?(citiesData)
            }
        }
    }

    func viewDidLoad() {
        DispatchQueue.main.async {
            self.cities = self.requestCities()
        }
    }

    private func requestCities() -> [String]? {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let citiesData = try JSONDecoder().decode(CitiesData.self, from: data)
                var array: [String] = []
                for cities in citiesData.data {
                    for city in cities.cities {
                        array.append("\(city), \(cities.country)")
                    }
                }
                let unique = Array(Set(array))
                return unique.sorted()
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
}
