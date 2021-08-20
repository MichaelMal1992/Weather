//
//  ViewController.swift
//  WeatherOn15DaysApp
//
//  Created by Admin on 15.07.21.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, WeatherViewControllerProtocol {

    @IBOutlet weak private var currentWeatherCollectionView: UICollectionView!
    @IBOutlet weak private var allWeatherTableView: UITableView!
    @IBOutlet weak private var currentConditionIconImageView: UIImageView!
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var currentDateLabel: UILabel!
    @IBOutlet weak private var currentTemperatureLabel: UILabel!
    @IBOutlet weak private var currentConditionLabel: UILabel!
    @IBOutlet weak private var currentTemperatureMinAndMax: UILabel!
    @IBOutlet weak private var currentFeelsLikeLabel: UILabel!
    @IBOutlet weak private var uvindexCurrentWeatherLabel: UILabel!
    @IBOutlet weak private var sunriseCurrentWeatherLabel: UILabel!
    @IBOutlet weak private var sunsetCurrentWeatherLabel: UILabel!
    @IBOutlet weak private var windSpeedCurrentWeatherLabel: UILabel!
    @IBOutlet weak private var humidityCurrentWeatherLabel: UILabel!
    @IBOutlet weak private var visibilityCurrentWeatherLabel: UILabel!
    @IBOutlet weak private var pressureCurrentWeatherLabel: UILabel!
    @IBOutlet weak private var heightMainContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    private let localeManager = CLLocationManager()
    private var isDisplayDidTurne = true

    override func viewDidLoad() {
        super.viewDidLoad()
        localeManager.delegate = self
        currentWeatherCollectionView.delegate = self
        currentWeatherCollectionView.dataSource = self
        allWeatherTableView.dataSource = self
        allWeatherTableView.delegate = self
        configurationLocaleManager()
        let nibCollection = UINib(nibName: String(describing: CurrentWeatherCollectionViewCell.self), bundle: nil)
        let collectionIdentifier = CurrentWeatherCollectionViewCell.identifier
        currentWeatherCollectionView.register(nibCollection, forCellWithReuseIdentifier: collectionIdentifier)
        let nibTable = UINib(nibName: String(describing: AllWeatherTableViewCell.self), bundle: nil)
        let tableIdentifier = AllWeatherTableViewCell.identifier
        allWeatherTableView.register(nibTable, forCellReuseIdentifier: tableIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestWeatherData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            coordinator.animate(alongsideTransition: nil) { _ in
                if self.isDisplayDidTurne {
                    self.heightMainContainerConstraint.constant = 440
                    self.isDisplayDidTurne = false
                } else {
                    self.heightMainContainerConstraint.constant = 0
                    self.isDisplayDidTurne = true
                }
            }
        }

    @IBAction private func reloadDataWeatherButtonPressed(_ sender: UIButton) {

        requestWeatherData()
    }

    @IBAction private func searchCityButtonPressed(_ sender: UIButton) {
        let name = String(describing: CitiesViewController.self)
        createViewController(name, name)
    }

    private func requestWeatherData() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        ManagerCities.shared.currentCity = UserDefaults.standard.value(forKey: "Current_City") as? String ?? ""
        let currentCity = ManagerCities.shared.currentCity.filter {$0 != " "}
        let string = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(currentCity)?unitGroup=metric&iconSet=icons2&key=5EMCD3JJPUY8HUAS7H8ZSMJHD"
        guard let url = URL(string: string) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("No data in response")
                return
            }
            if let weather = try? JSONDecoder().decode(Weather.self, from: data) {
                    ManagerCities.shared.weather = weather
                    if ManagerCities.shared.isChangeCity {
                        let userDefaults = UserDefaults.standard
                        let currentCity = ManagerCities.shared.currentCity
                        userDefaults.setValue("\(weather.resolvedAddress ?? "") (\(currentCity))", forKey: "Name_City")
                    }
                    if ManagerCities.shared.isGeoLocationDidUpdate {
                        UserDefaults.standard.setValue(ManagerCities.shared.geoLocationResponse, forKey: "Name_City")
                    }
                    ManagerCities.shared.isGeoLocationDidUpdate = false
                    ManagerCities.shared.isChangeCity = false
                    ManagerCities.shared.nameCity = UserDefaults.standard.value(forKey: "Name_City") as? String ?? ""
                DispatchQueue.main.async {
                    self.reloadDataCurrentWeather(weather)
                    self.allWeatherTableView.reloadData()
                    self.currentWeatherCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            } else {
                print("Bad Weather")
            }
        }
        task.resume()
    }

    private func requestGeoLocationData(_ locations: [CLLocation]) {
        let latitude = locations.last?.coordinate.latitude ?? 0
        let longitude = locations.last?.coordinate.longitude ?? 0
        let string = "https://nominatim.openstreetmap.org/reverse?format=json&lat=\(latitude)&lon=\(longitude)&accept-language=ru&zoom=20&addressdetails=1&"
        guard let url = URL(string: string) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("No data in response")
                return
            }
            if let location = try? JSONDecoder().decode(GeoLocation.self, from: data) {
                ManagerCities.shared.isChangeCity = false
                ManagerCities.shared.isGeoLocationDidUpdate = true
                let last = "\(locations.last?.coordinate.latitude ?? 0),\(locations.last?.coordinate.longitude ?? 0)"
                ManagerCities.shared.currentCity = last
                UserDefaults.standard.setValue(ManagerCities.shared.currentCity, forKey: "Current_City")
                ManagerCities.shared.geoLocationResponse = location.display
                self.requestWeatherData()
            } else {
                print("Bad weather")
            }
        }
        task.resume()
    }

    private func reloadDataCurrentWeather(_ weather: Weather?) {
        guard let weather = weather else {
            return
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = "\(weather.days?.first?.datetime ?? "") \(weather.currentConditions.datetime ?? "")"
        guard let dateFromString = dateFormater.date(from: dateString) else {
            return
        }
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "E, d MMM HH:mm"
        let stringFromeDate = dateFormatter2.string(from: dateFromString)
        cityLabel.text = ManagerCities.shared.nameCity
        UserDefaults.standard.setValue(ManagerCities.shared.nameCity, forKey: "Name_City")
        currentDateLabel.text = stringFromeDate
        currentTemperatureLabel.text = String("\(Int(weather.currentConditions.temp ?? 0))°")
        currentConditionLabel.text = weather.currentConditions.conditions ?? ""
        let temMax = weather.days?.first?.tempmax ?? 0
        let tempMin = weather.days?.first?.tempmin ?? 0
        currentTemperatureMinAndMax.text = "\(String(Int(temMax)))°/\(String(Int(tempMin)))°"
        currentFeelsLikeLabel.text = String("Feels like \(Int(weather.currentConditions.feelslike ?? 0))°")
        currentConditionIconImageView.image = UIImage(named: weather.currentConditions.icon ?? "")
        uvindexCurrentWeatherLabel.text = String(weather.days?.first?.uvindex ?? 0)
        sunriseCurrentWeatherLabel.text = weather.currentConditions.sunrise ?? ""
        sunsetCurrentWeatherLabel.text = weather.currentConditions.sunset ?? ""
        windSpeedCurrentWeatherLabel.text = "\(String(weather.currentConditions.windspeed ?? 0)) km/h"
        humidityCurrentWeatherLabel.text = "\(String(weather.currentConditions.humidity ?? 0))%"
        visibilityCurrentWeatherLabel.text = "\(String(weather.currentConditions.visibility ?? 0)) km"
        pressureCurrentWeatherLabel.text = "\(String(weather.currentConditions.pressure ?? 0)) mbar"
        }

    private func configurationLocaleManager() {
        localeManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        localeManager.requestAlwaysAuthorization()
        localeManager.distanceFilter = 100
    }
}

extension WeatherViewController: UICollectionViewDelegate {

}
extension WeatherViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let weather = ManagerCities.shared.weather else {
            return 0
        }
        let count = weather.days?.first?.hours?.count ?? 0
        return count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeue = currentWeatherCollectionView.dequeueReusableCell
        let identifier = CurrentWeatherCollectionViewCell.identifier
        guard let cell = dequeue(identifier, indexPath) as? CurrentWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let weather = ManagerCities.shared.weather else {
            return cell
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm:ss"
        let dateString = weather.days?.first?.hours?[indexPath.item].datetime ?? ""
        let dateFromString = dateFormater.date(from: dateString) ?? Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm"
        let stringFromeDate = dateFormatter2.string(from: dateFromString)
        cell.currentConditionImageView.image = UIImage(named: weather.days?.first?.hours?[indexPath.item].icon ?? "")
        cell.humidityCurentLabel.text = "\(String(Int(weather.days?.first?.hours?[indexPath.item].humidity ?? 0)))%"
        cell.temperatureCurentLabel.text = "\(String(Int(weather.days?.first?.hours?[indexPath.item].temp ?? 0)))°"
        cell.timeCurentLabel.text = stringFromeDate
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
}

extension WeatherViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weather = ManagerCities.shared.weather else {
            return 0
        }
        let count = weather.days?.count
        return count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = AllWeatherTableViewCell.identifier
        let dequeue = allWeatherTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let cell = dequeue as? AllWeatherTableViewCell else {
            return UITableViewCell()
        }
        guard let weather = ManagerCities.shared.weather else {
            return cell
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateString = weather.days?[indexPath.row].datetime ?? ""
        let dateFromString = dateFormater.date(from: dateString) ?? Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE"
        let stringFromeDate = dateFormatter2.string(from: dateFromString)
        cell.conditionIconImageView.image = UIImage(named: weather.days?[indexPath.row].icon ?? "")
        cell.dateOfWeekLabel.text = stringFromeDate
        let tempMax = weather.days?[indexPath.row].tempmax ?? 0
        let tempMin = weather.days?[indexPath.row].tempmin ?? 0
        cell.maxAndMinTemperatureLabel.text = "\(String(Int(tempMax)))°/\(String(Int(tempMin)))°"
        cell.procentHumidityLabel.text = "\(String(Int(weather.days?[indexPath.row].humidity ?? 0)))%"
        cell.windSpeedLabel.text = "\(String(weather.days?[indexPath.row].windspeed ?? 0))km/h"
        return cell
    }
}

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        requestGeoLocationData(locations)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            return
        default:
            manager.startUpdatingLocation()
        }
    }
}
