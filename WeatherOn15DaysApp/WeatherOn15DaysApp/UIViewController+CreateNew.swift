//
//  FactoryViewControllers.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit

extension UIViewController {

    func createViewController(_ viewController: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: viewController)
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        present(newViewController, animated: true)
    }
}
