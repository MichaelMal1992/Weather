//
//  ListOfCitiesViewController.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit

class CitiesViewController: UIViewController {

    @IBOutlet private weak var citiesTableView: UITableView!
    @IBOutlet private weak var citiesTextField: UITextField!

    private var viewModel: CitiesViewModel?
    private var sortedCities: [String]?
    private var cities: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = CitiesViewModelImplementation(CitiesViewController())
        self.viewModel?.didUpdateData = { cities in
            self.cities = cities
        }
        self.viewModel?.viewDidLoad()
        setupTableView()
        setupTextField()
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

    private func setupTableView() {
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        citiesTableView.isHidden = true
    }

    private func setupTextField() {
        citiesTextField.becomeFirstResponder()
        citiesTextField.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeCities),
                                               name: UITextField.textDidChangeNotification,
                                               object: citiesTextField)
    }

    @objc private func didChangeCities() {
        if let text = citiesTextField.text {
            if text.isEmpty == false {
                citiesTableView.isHidden = false
                if let cities = self.cities {
                    self.sortedCities = cities.filter {$0.lowercased().contains(text.lowercased())}
                }
            } else {
                citiesTableView.isHidden = true
            }
        }
        citiesTableView.reloadData()
    }
}

extension CitiesViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        citiesTextField.resignFirstResponder()
        return true
    }
}

extension CitiesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentCity = self.sortedCities?[indexPath.row] {
            UserDefaults.standard.setValue(currentCity, forKey: "Current_City")
            ManagerCities.shared.isGeoLocationDidUpdate = false
            ManagerCities.shared.isChangeCity = true
            dismiss(animated: true)
        }
    }
}

extension CitiesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sortedCities = self.sortedCities {
            return sortedCities.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let sortedCities = self.sortedCities {
            cell.textLabel?.text = sortedCities[indexPath.row]
        }
        return cell
    }
}
