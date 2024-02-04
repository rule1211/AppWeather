//
//  ViewController.swift
//  WeatherCustomApp
//
//  Created by Stefan Ruzic on 11.7.22..
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    var layer = CAGradientLayer()
    let date = Date()
    let df = DateFormatter()
    let dfT = DateFormatter()
    
    @IBOutlet weak var currentMaxTemp: UILabel!
    @IBOutlet weak var currentMinTemp: UILabel!
    
    var pickCity: String = "Belgrade"
    var metric = "metric"
    var imperial = "imperial"
    
    @IBOutlet weak var bVIew: UIView!
    @IBOutlet weak var currentPressure: UILabel!
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var changeFormat: UISwitch!
    @IBOutlet weak var chooseCity: UITextField!
    @IBOutlet weak var goSearchCity: UIButton!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var currentHumidity: UILabel!
    @IBOutlet weak var sunRise: UILabel!
    @IBOutlet weak var sunSet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        df.dateStyle = .medium
        dfT.timeStyle = .short
        let timeString = dfT.string(from: date)
        let dateString = df.string(from: date)
        self.currentDate.text = dateString
        self.currentTime.text = timeString
        
        chooseCity.delegate = self
        CelsOrFahr(changeFormat)
    }

    func loadData(for city: String) {
        var format = ""
        if changeFormat.isOn {
            format = metric
        } else {
            format = imperial
        }
        
        ApiManager.shared.fetchOpenWeatherApi(city: pickCity, format: format ) { (result) in
            switch result {
            case .success(let currentWeather):
                self.successResponse(currentWeather: currentWeather, format: format)
                
            case .failure(let error):
                self.failureResponse(error: error)
            }
        }
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        if  let text = chooseCity.text {
            pickCity = text
            loadData(for: pickCity)
        }
    }
    
    @IBAction func CelsOrFahr(_ sender: UISwitch) {
        if changeFormat.isOn {
            loadData(for: pickCity)
        }
        loadData(for: pickCity)
    }
}


private extension ViewController {
    func successResponse(currentWeather: OpenWeatherResponse, format: String) {
        DispatchQueue.main.async {
            print(currentWeather)
            
            if format == self.imperial {
                self.currentTemperature.text = "\(Int(currentWeather.main.current))°F"
                self.currentMaxTemp.text = "\(Int(currentWeather.main.tempMax))°F"
                self.currentMinTemp.text = "\(Int(currentWeather.main.tempMin))°F"
            } else {
                self.currentTemperature.text = "\(Int(currentWeather.main.current))°C"
                self.currentMaxTemp.text = "\(Int(currentWeather.main.tempMax))°C"
                self.currentMinTemp.text = "\(Int(currentWeather.main.tempMin))°C"
            }
            
            self.currentPressure.text = "\(Int(currentWeather.main.pressure))"
            self.currentIcon.image = UIImage(named: currentWeather.weather[0].icon)
            self.currentHumidity.text = "\(Int(currentWeather.main.humidity))%"
            let sunRiseConvert = currentWeather.sys.sunrise
            let sunSetConvert = currentWeather.sys.sunset
            let newSunRiseConvert = Date(timeIntervalSince1970: TimeInterval(sunRiseConvert))
            let newSunSetConvert = Date(timeIntervalSince1970: TimeInterval(sunSetConvert))
            let dataFormat = DateFormatter()
            dataFormat.timeStyle = .short
            let timeSunRise = dataFormat.string(from: newSunRiseConvert)
            let timeSunSet = dataFormat.string(from: newSunSetConvert)

            self.sunRise.text = "\(timeSunRise)"
            self.sunSet.text = "\(timeSunSet)"
            
        }
    }
    
    func failureResponse(error: Error) {
        DispatchQueue.main.async {
            self.currentTemperature.text = error.localizedDescription
            self.currentMaxTemp.text = error.localizedDescription
            self.currentMinTemp.text = error.localizedDescription
            self.currentPressure.text = error.localizedDescription
            self.currentHumidity.text = error.localizedDescription
            self.sunRise.text = error.localizedDescription
            self.sunSet.text = error.localizedDescription
        }
    }
    
    
}

