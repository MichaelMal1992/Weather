//
//  ListOfCitiesViewController.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit

class ListOfCitiesViewController: UIViewController {

    @IBOutlet weak var listCitiesTableView: UITableView!
    @IBOutlet weak var listCitiesTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        listCitiesTextField.becomeFirstResponder()
        listCitiesTextField.delegate = self
        listCitiesTableView.dataSource = self
        listCitiesTableView.delegate = self
        listCitiesTableView.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(listCitiesTextFieldTextDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: listCitiesTextField)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

    @objc func listCitiesTextFieldTextDidChange() {
        if let text = listCitiesTextField.text {
            if text.isEmpty == false {
                listCitiesTableView.isHidden = false
                let cities = ManagerData.shared.citiesStringArray
                ManagerData.shared.sortedCitiesStringArray = cities.filter {$0.lowercased().contains(text.lowercased())}
            } else {
                listCitiesTableView.isHidden = true
            }
        }
        listCitiesTableView.reloadData()
    }
}

extension ListOfCitiesViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        listCitiesTextField.resignFirstResponder()
        return true
    }
}

extension ListOfCitiesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ManagerData.shared.currentCity = ManagerData.shared.sortedCitiesStringArray[indexPath.row]
        UserDefaults.standard.setValue(ManagerData.shared.currentCity, forKey: "Current_City")
        ManagerData.shared.isGeoLocationDidUpdate = false
        ManagerData.shared.isChangeCity = true
        dismiss(animated: true)
    }
}

extension ListOfCitiesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManagerData.shared.sortedCitiesStringArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ManagerData.shared.sortedCitiesStringArray[indexPath.row]
        return cell
    }
}
