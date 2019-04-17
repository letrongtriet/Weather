//
//  WeatherDatasource.swift
//  Weather
//
//  Created by Triet MaaS Global on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import UIKit

class WeatherDatasource: NSObject, UITableViewDataSource {
    let cache = NSCache<NSString, Weather>()
    
    var airportIdentifier = ""
    
    fileprivate let detailViewCellId = "DetailViewCell"
    
    var urlString = ""
    
    lazy var timer = Timer()

    var shouldShowForrcast = false {
        didSet {
            self.dataChanged?()
        }
    }
    
    var weather: Weather? {
        didSet {
            cache.setObject(weather!, forKey: NSString(string: airportIdentifier))
            self.dataChanged?()
        }
    }
    
    var dataChanged: (() -> Void)?
    
    func fetch() {
        print(airportIdentifier)
        if let tempWeather = cache.object(forKey: NSString(string: airportIdentifier)) {
            print("YES")
            self.weather = tempWeather
        } else {
            print("NO")
            self.fetchNewWeather()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.fetchNewWeather), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func fetchNewWeather() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        decoder.decode(Weather.self, fromURL: urlString) { result in
            print(result)
            self.weather = result
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if shouldShowForrcast {
            return weather?.report.forecast?.conditions.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if shouldShowForrcast {
            return stringToDateString(for: weather?.report.forecast?.conditions[section].dateIssued)
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailViewCellId, for: indexPath) as! DetailTableViewCell
        
        return cell
    }
}
