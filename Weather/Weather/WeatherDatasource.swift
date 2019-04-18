//
//  WeatherDatasource.swift
//  Weather
//
//  Created by Triet Le on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherDatasource: NSObject, UITableViewDataSource {
    let cache = CacheManager.shareInstance
    
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
            self.dataChanged?()
        }
    }
    
    var dataChanged: (() -> Void)?
    
    /// functions
    func fetch() {
        if let tempWeather = self.cache.getObject(for: airportIdentifier) {
            print("Cache is available")
            self.weather = tempWeather
        } else {
            print("Cache is not available")
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
            self.cache.cacheObject(for: result, key: self.airportIdentifier)
            
            self.weather = result
        }
    }
    
    /// Table view data source
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailViewCellId, for: indexPath) as! DetailTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
