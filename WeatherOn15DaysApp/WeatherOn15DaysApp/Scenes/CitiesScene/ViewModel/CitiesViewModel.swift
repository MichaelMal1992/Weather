//
//  CitiesViewModel.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 19.08.21.
//

import Foundation
import UIKit

protocol CitiesViewModel {

    var didUpdateData: (([String]) -> Void)? { get set }
    func viewDidLoad()
}
