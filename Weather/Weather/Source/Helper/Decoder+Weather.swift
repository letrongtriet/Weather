//
//  Decoder+Weather.swift
//  Weather
//
//  Created by Triet Le on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: url) else {
            showAlert(with: "Invalid URL passed.")
            return
        }
        
        runOnBackGround {
            do {
                let data = try Data(contentsOf: url)
                let downloadedData = try self.decode(type, from:
                    data)
                
                runOnMainThread {
                    completion(downloadedData)
                }
            } catch {
                runOnMainThread {
                    showAlert(with: error.localizedDescription)
                }
            }
        }
    }
    
}
