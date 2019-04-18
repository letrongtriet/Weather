//
//  DetailTableViewController.swift
//  Weather
//
//  Created by Triet Le on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var airportIdentifier = String()
    
    let dataSource = WeatherDatasource()
    
    fileprivate let baseURL = "https://qa.foreflight.com/weather/report/"
    
    fileprivate let detailViewCellId = "DetailViewCell"
    
    /// Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableview()
        ui()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dataSource.timer.invalidate()
    }
    
    /// Table view delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.dataSource.shouldShowForrcast && self.dataSource.weather?.report.forecast != nil {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.lightGray
            
            let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
                tableView.bounds.size.width, height: tableView.bounds.size.height))
            headerLabel.font = UIFont(name: "Verdana", size: 17)
            headerLabel.textColor = UIColor.white
            headerLabel.text = stringToDateString(for: self.dataSource.weather?.report.forecast?.conditions[section].dateIssued)
            headerLabel.sizeToFit()
            
            headerView.addSubview(headerLabel)
            
            return headerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.dataSource.shouldShowForrcast && self.dataSource.weather?.report.forecast != nil {
            return 25
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? DetailTableViewCell else { return }
        
        if !self.dataSource.shouldShowForrcast {
            guard let condition = self.dataSource.weather?.report.conditions else {
                cell.populateEmptyCell()
                return
            }
            
            cell.populateCondition(condition)
        } else {
            guard let forecast = self.dataSource.weather?.report.forecast else {
                cell.populateEmptyCell()
                return
            }
            
            cell.populateForecast(forecast, condition: forecast.conditions[indexPath.section])
        }
    }
    
}

/// functions
extension DetailTableViewController {
    
    func configTableview() {
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        let urlString = baseURL + airportIdentifier
        
        dataSource.urlString = urlString
        dataSource.airportIdentifier = self.airportIdentifier
        dataSource.fetch()
        
        tableView.dataSource = dataSource
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: detailViewCellId)
    }
    
    func ui() {
        let logoutBarButtonItem = UIBarButtonItem(title: "Forecast", style: .plain, target: self, action: #selector(showForecast))
        navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc func showForecast() {
        self.dataSource.shouldShowForrcast.toggle()
        
        if self.dataSource.shouldShowForrcast {
            self.navigationItem.rightBarButtonItem?.title = "Condition"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Forecast"
        }
    }
    
}
