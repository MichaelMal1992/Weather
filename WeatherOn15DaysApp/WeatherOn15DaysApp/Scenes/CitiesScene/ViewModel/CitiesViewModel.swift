//
//  CitiesViewModel.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 19.08.21.
//

import Foundation

protocol CitiesViewModel {

    var didUpdateData: (([String]) -> ())? { get set }
    func viewDidLoad()
}
