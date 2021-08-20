//
//  FactoryViewControllers.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit

extension UIViewController {

    func createViewController(_ viewController: String, _ storyboard: String) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: viewController)
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        present(newViewController, animated: true)
    }
}
