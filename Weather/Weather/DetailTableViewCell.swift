//
//  DetailTableViewCell.swift
//  Weather
//
//  Created by Triet Le on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import UIKit
import CoreLocation

class DetailTableViewCell: UITableViewCell {
    
    /// IBOutlet
    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var temperationTitle: UILabel!
    
    /// functions
    func populateCondition(_ condition: ReportConditions) {
        let lon = condition.lon
        let lat = condition.lat
        
        let location = CLLocation(latitude: lat, longitude: lon)
        
        getPlacemark(forLocation: location) {
            (originPlacemark, error) in
            if error != nil {
                self.airportName.text = "Unknown"
            } else if let placemark = originPlacemark {
                if let name = placemark.name {
                    self.airportName.text = name
                } else {
                    self.airportName.text = "Unknown"
                }
            }
        }

        self.temperature.text = "\(condition.tempC) ℃"
        self.humidity.text = "\(condition.relativeHumidity) g/m3"
        self.visibility.text = "\(condition.visibility.distanceSm) Sm"
        
        let tempString = condition.weather.joined(separator:" | ")
        
        if tempString != ""{
            self.weatherLabel.text = tempString
        } else {
            self.weatherLabel.text = "No report"
        }
    }
    
    func populateForecast(_ forecast: ReportForecast, _ index: Int) {
        let condition = forecast.conditions[index]
        
        let lon = forecast.lon
        let lat = forecast.lat
        
        let location = CLLocation(latitude: lat, longitude: lon)
        
        getPlacemark(forLocation: location) {
            (originPlacemark, error) in
            if error != nil {
                self.airportName.text = "Unknown"
            } else if let placemark = originPlacemark {
                if let name = placemark.name {
                    self.airportName.text = name
                } else {
                    self.airportName.text = "Unknown"
                }
            }
        }
        
        self.temperationTitle.text = "Wind speed"
        
        if let tempWindSpeed = condition.wind?.speedKts {
            temperature.text = "\(tempWindSpeed) knots"
        } else {
            temperature.text = "Not available"
        }
        
        self.humidity.text = "\(condition.relativeHumidity) g/m3"
        self.visibility.text = "\(condition.visibility.distanceSm) Sm"
        
        let tempString = condition.weather.joined(separator:" | ")
        
        if tempString != ""{
            self.weatherLabel.text = tempString
        } else {
            self.weatherLabel.text = "No report"
        }
    }
}
