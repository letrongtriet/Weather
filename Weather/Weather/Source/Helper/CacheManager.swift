//
//  CacheManager.swift
//  Weather
//
//  Created by Triet Le on 18/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import Foundation

class CacheManager {
    
    init(){}
    
    static let shareInstance: CacheManager = CacheManager()
    
    let cache = NSCache<NSString, Weather>()
    
    func cacheObject(for object: Weather, key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    func getObject(for key: String) -> Weather? {
        return cache.object(forKey: key as NSString)
    }
    
}
