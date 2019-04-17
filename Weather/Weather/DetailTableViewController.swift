//
//  DetailTableViewController.swift
//  Weather
//
//  Created by Triet MaaS Global on 17/04/2019.
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
        
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        let urlString = baseURL + airportIdentifier
        
        dataSource.urlString = urlString
        dataSource.airportIdentifier = self.airportIdentifier
        dataSource.fetch()
        
        tableView.dataSource = dataSource
        
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: detailViewCellId)
        
        ui()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dataSource.timer.invalidate()
    }
    
}

extension DetailTableViewController {
    
    func ui() {
        let showForeCastSwitch = UISwitch(frame: .zero)
        showForeCastSwitch.isOn = false
        showForeCastSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        let switchView = UIBarButtonItem(customView: showForeCastSwitch)
        navigationItem.rightBarButtonItem = switchView
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        self.dataSource.shouldShowForrcast = sender.isOn
    }
    
}
