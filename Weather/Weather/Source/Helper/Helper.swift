//
//  Helper.swift
//  Weather
//
//  Created by Triet Le on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import UIKit
import CoreLocation

public func showAlert(with message: String) {
    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    
    let doneAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(doneAction)
    alertController.view.tintColor = .black
    
    runOnMainThread {
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

/// Executing task on background thread
public func runOnBackGround(qos: DispatchQoS.QoSClass = .utility, task: @escaping () -> Void) {
    if qos.isCurrent {
        task()
    } else {
        DispatchQueue.global(qos: qos).async(execute: task)
    }
}

/// Executing task on main thread
public func runOnMainThread(task: @escaping () -> Void) {
    if Thread.isMainThread {
        task()
    } else {
        DispatchQueue.main.async(execute: task)
    }
}

extension DispatchQoS.QoSClass {
    var isCurrent: Bool {
        var qosClass: DispatchQoS.QoSClass?
        
        switch Thread.current.qualityOfService {
        case .background:
            qosClass = .background
        case .default:
            qosClass = .default
        case .userInitiated:
            qosClass = .userInitiated
        case .userInteractive:
            qosClass = .userInteractive
        case .utility:
            qosClass = .utility
        @unknown default:
            break
        }
        
        return self == qosClass
    }
}

public func stringToDateString(for string: String?) -> String? {
    guard let string = string else {return nil}
    
    let dateFormatter = ISO8601DateFormatter()
    guard let date = dateFormatter.date(from: string) else {return nil}
    
    let normalizedDateFormatter = DateFormatter()
    normalizedDateFormatter.timeZone = TimeZone.current
    normalizedDateFormatter.locale = Locale.current
    normalizedDateFormatter.dateFormat = "EEEE, dd.MM.yyyy HH:mm v"
    
    return normalizedDateFormatter.string(from: date)
}

func getPlacemark(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> ()) {
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location, completionHandler: {
        placemarks, error in
        
        if let err = error {
            completionHandler(nil, err.localizedDescription)
        } else if let placemarkArray = placemarks {
            if let placemark = placemarkArray.first {
                completionHandler(placemark, nil)
            } else {
                completionHandler(nil, "Placemark was nil")
            }
        } else {
            completionHandler(nil, "Unknown error")
        }
    })
    
}
