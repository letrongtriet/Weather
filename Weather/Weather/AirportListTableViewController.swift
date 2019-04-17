//
//  AirportListTableViewController.swift
//  Weather
//
//  Created by Triet MaaS Global on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import UIKit

class AirportListTableViewController: UITableViewController {
    
    var airports: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var didSelectAirport: ((String) -> Void)?
    
    fileprivate let airportListCellIdentifier = "AirportListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: airportListCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = airports[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectAirport?(airports[indexPath.row])
    }

}
