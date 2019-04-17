//
//  WeatherViewController.swift
//  Weather
//
//  Created by Triet MaaS Global on 17/04/2019.
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
    
}
