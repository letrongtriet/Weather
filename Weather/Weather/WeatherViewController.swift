//
//  WeatherViewController.swift
//  Weather
//
//  Created by Triet Le on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var airports: [String] = UserDefaults.standard.object(forKey: "ListOfAirport") as? [String] ?? ["KPWM", "KAUS"] {
        didSet {
            self.airportListTableViewController?.airports = airports
            UserDefaults.standard.set(self.airports, forKey: "ListOfAirport")
        }
    }
    
    var selectedAirports: [String] = UserDefaults.standard.object(forKey: "SelectedAirports") as? [String] ?? [] {
        didSet {
            UserDefaults.standard.set(self.selectedAirports, forKey: "SelectedAirports")
        }
    }
    
    var currentWeatherObject: Weather?
    
    var airportListTableViewController: AirportListTableViewController?
    
    /// Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.destination {
            
        case let vc as AirportListTableViewController:
            self.airportListTableViewController = vc
            self.airportListTableViewController?.airports = airports
            
            self.airportListTableViewController?.didSelectAirport = { [weak self] (airport) in
                print(airport)
                
                if let temp = self?.selectedAirports.contains(airport) {
                    if !temp {
                        self?.selectedAirports.append(airport)
                    }
                }
                
                self?.showDetailView(with: airport)
            }
            
        default:
            break
        }
        
    }
    
    /// IBAction
    @IBAction func addNewAirport(_ sender: UIBarButtonItem) {
        showAddNewAirportAlert()
    }
    
    @IBAction func showHistory(_ sender: UIBarButtonItem) {
        showHistory()
    }
    
}

/// Private functions
extension WeatherViewController {
    
    func showAddNewAirportAlert() {
        let alertController = UIAlertController(title: "New Aiport", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter airport identifier"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (alert) in
            guard let alertTextFields = alertController.textFields else {return}
            guard alertTextFields.count > 0 else {return}
            let airportInputTextField = alertTextFields[0]
            
            if let inputString = airportInputTextField.text {
                let tempString = inputString.uppercased()
                guard !self.airports.contains(tempString) else {return}
                self.airports.append(tempString)
            } else {
                showAlert(with: "Field cannot be left empty")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        alertController.view.tintColor = .black
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showDetailView(with airportIdentifer: String) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        
        detailViewController.airportIdentifier = airportIdentifer.lowercased()
        
        runOnMainThread {
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func showHistory() {
        guard selectedAirports.count > 0 else {
            showAlert(with: "History is empty")
            return
        }
        
        let actionSheet = UIAlertController(title: "Viewed Airports", message: nil, preferredStyle: .actionSheet)
        
        for airport in selectedAirports {
            actionSheet.addAction(UIAlertAction(title: airport, style: .default, handler: nil))
        }
        
        actionSheet.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        actionSheet.view.tintColor = .blue
        
        runOnMainThread {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
}
