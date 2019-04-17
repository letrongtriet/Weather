//
//  WeatherModel.swift
//  Weather
//
//  Created by Triet MaaS Global on 17/04/2019.
//  Copyright © 2019 Triet Le. All rights reserved.
//

import Foundation

class Weather: Codable {
    let report: Report
    
    init(report: Report) {
        self.report = report
    }
}

class Report: Codable {
    let conditions: ReportConditions?
    let forecast: ReportForecast?
    let windsAloft: ReportWindsAloft
    let mos: MOS?
    let atis: [Ati]?
    
    init(conditions: ReportConditions?, forecast: ReportForecast?, windsAloft: ReportWindsAloft, mos: MOS?, atis: [Ati]?) {
        self.conditions = conditions
        self.forecast = forecast
        self.windsAloft = windsAloft
        self.mos = mos
        self.atis = atis
    }
}

class Ati: Codable {
    let text, ident: String
    let dateIssued: String
    let source, letter: String
    let conditions: AtiConditions
    
    init(text: String, ident: String, dateIssued: String, source: String, letter: String, conditions: AtiConditions) {
        self.text = text
        self.ident = ident
        self.dateIssued = dateIssued
        self.source = source
        self.letter = letter
        self.conditions = conditions
    }
}

class AtiConditions: Codable {
    let text, ident: String
    let tempC, dewpointC: Int
    let pressureHg: Double
    let relativeHumidity: Int
    let flightRules: String
    let cloudLayers, cloudLayersV2: [CloudLayer]
    let weather: [String]
    let visibility: PurpleVisibility
    let wind: Wind
    
    init(text: String, ident: String, tempC: Int, dewpointC: Int, pressureHg: Double, relativeHumidity: Int, flightRules: String, cloudLayers: [CloudLayer], cloudLayersV2: [CloudLayer], weather: [String], visibility: PurpleVisibility, wind: Wind) {
        self.text = text
        self.ident = ident
        self.tempC = tempC
        self.dewpointC = dewpointC
        self.pressureHg = pressureHg
        self.relativeHumidity = relativeHumidity
        self.flightRules = flightRules
        self.cloudLayers = cloudLayers
        self.cloudLayersV2 = cloudLayersV2
        self.weather = weather
        self.visibility = visibility
        self.wind = wind
    }
}

class CloudLayer: Codable {
    let coverage: String
    let altitudeFt: Int
    let ceiling: Bool
    let type: String?
    let altitudeQualifier: Int?
    
    init(coverage: String, altitudeFt: Int, ceiling: Bool, type: String?, altitudeQualifier: Int?) {
        self.coverage = coverage
        self.altitudeFt = altitudeFt
        self.ceiling = ceiling
        self.type = type
        self.altitudeQualifier = altitudeQualifier
    }
}

class PurpleVisibility: Codable {
    let distanceSm, prevailingVisSm: Int
    
    init(distanceSm: Int, prevailingVisSm: Int) {
        self.distanceSm = distanceSm
        self.prevailingVisSm = prevailingVisSm
    }
}

class Wind: Codable {
    let speedKts: Double
    let direction, from: Int?
    let variable: Bool
    let gustSpeedKts: Double?
    
    init(speedKts: Double, direction: Int?, from: Int?, variable: Bool, gustSpeedKts: Double?) {
        self.speedKts = speedKts
        self.direction = direction
        self.from = from
        self.variable = variable
        self.gustSpeedKts = gustSpeedKts
    }
}

class ReportConditions: Codable {
    let text, ident: String
    let dateIssued: String
    let lat, lon: Double
    let elevationFt, tempC, dewpointC: Int
    let pressureHg: Double
    let densityAltitudeFt, relativeHumidity: Int
    let flightRules: String
    let cloudLayers, cloudLayersV2: [CloudLayer]
    let weather: [String]
    let visibility: FluffyVisibility
    let wind: Wind
    
    init(text: String, ident: String, dateIssued: String, lat: Double, lon: Double, elevationFt: Int, tempC: Int, dewpointC: Int, pressureHg: Double, densityAltitudeFt: Int, relativeHumidity: Int, flightRules: String, cloudLayers: [CloudLayer], cloudLayersV2: [CloudLayer], weather: [String], visibility: FluffyVisibility, wind: Wind) {
        self.text = text
        self.ident = ident
        self.dateIssued = dateIssued
        self.lat = lat
        self.lon = lon
        self.elevationFt = elevationFt
        self.tempC = tempC
        self.dewpointC = dewpointC
        self.pressureHg = pressureHg
        self.densityAltitudeFt = densityAltitudeFt
        self.relativeHumidity = relativeHumidity
        self.flightRules = flightRules
        self.cloudLayers = cloudLayers
        self.cloudLayersV2 = cloudLayersV2
        self.weather = weather
        self.visibility = visibility
        self.wind = wind
    }
}

class FluffyVisibility: Codable {
    let distanceSm, prevailingVisSm: Double
    let distanceQualifier, prevailingVisDistanceQualifier: Int?
    
    init(distanceSm: Double, prevailingVisSm: Double, distanceQualifier: Int?, prevailingVisDistanceQualifier: Int?) {
        self.distanceSm = distanceSm
        self.prevailingVisSm = prevailingVisSm
        self.distanceQualifier = distanceQualifier
        self.prevailingVisDistanceQualifier = prevailingVisDistanceQualifier
    }
}

class ReportForecast: Codable {
    let text, ident: String
    let dateIssued: String
    let period: Period
    let lat, lon: Double
    let elevationFt: Int
    let conditions: [PurpleCondition]
    
    init(text: String, ident: String, dateIssued: String, period: Period, lat: Double, lon: Double, elevationFt: Int, conditions: [PurpleCondition]) {
        self.text = text
        self.ident = ident
        self.dateIssued = dateIssued
        self.period = period
        self.lat = lat
        self.lon = lon
        self.elevationFt = elevationFt
        self.conditions = conditions
    }
}

class PurpleCondition: Codable {
    let text: String
    let dateIssued: String
    let lat, lon: Double
    let elevationFt, relativeHumidity: Int
    let flightRules: String
    let cloudLayers, cloudLayersV2: [CloudLayer]
    let weather: [String]
    let visibility: FluffyVisibility
    let wind: Wind?
    let period: Period
    let change: String?
    
    init(text: String, dateIssued: String, lat: Double, lon: Double, elevationFt: Int, relativeHumidity: Int, flightRules: String, cloudLayers: [CloudLayer], cloudLayersV2: [CloudLayer], weather: [String], visibility: FluffyVisibility, wind: Wind?, period: Period, change: String?) {
        self.text = text
        self.dateIssued = dateIssued
        self.lat = lat
        self.lon = lon
        self.elevationFt = elevationFt
        self.relativeHumidity = relativeHumidity
        self.flightRules = flightRules
        self.cloudLayers = cloudLayers
        self.cloudLayersV2 = cloudLayersV2
        self.weather = weather
        self.visibility = visibility
        self.wind = wind
        self.period = period
        self.change = change
    }
}

class Period: Codable {
    let dateStart, dateEnd: String
    
    init(dateStart: String, dateEnd: String) {
        self.dateStart = dateStart
        self.dateEnd = dateEnd
    }
}

class MOS: Codable {
    let station: String
    let issued: String
    let latitude, longitude: Double
    let forecast: MOSForecast
    
    init(station: String, issued: String, latitude: Double, longitude: Double, forecast: MOSForecast) {
        self.station = station
        self.issued = issued
        self.latitude = latitude
        self.longitude = longitude
        self.forecast = forecast
    }
}

class MOSForecast: Codable {
    let text, ident: String
    let dateIssued: String
    let period: Period
    let lat, lon: Double
    let elevationFt: Int
    let conditions: [FluffyCondition]
    
    init(text: String, ident: String, dateIssued: String, period: Period, lat: Double, lon: Double, elevationFt: Int, conditions: [FluffyCondition]) {
        self.text = text
        self.ident = ident
        self.dateIssued = dateIssued
        self.period = period
        self.lat = lat
        self.lon = lon
        self.elevationFt = elevationFt
        self.conditions = conditions
    }
}

class FluffyCondition: Codable {
    let text: String
    let tempMinC, tempMaxC, dewpointMinC, dewpointMaxC: Double
    let flightRules: String
    let cloudLayers, cloudLayersV2: [CloudLayer]
    let weather: [String]
    let visibility: TentacledVisibility
    let wind: Wind
    let period: Period
    let turbulence, icing: [Bool]
    
    init(text: String, tempMinC: Double, tempMaxC: Double, dewpointMinC: Double, dewpointMaxC: Double, flightRules: String, cloudLayers: [CloudLayer], cloudLayersV2: [CloudLayer], weather: [String], visibility: TentacledVisibility, wind: Wind, period: Period, turbulence: [Bool], icing: [Bool]) {
        self.text = text
        self.tempMinC = tempMinC
        self.tempMaxC = tempMaxC
        self.dewpointMinC = dewpointMinC
        self.dewpointMaxC = dewpointMaxC
        self.flightRules = flightRules
        self.cloudLayers = cloudLayers
        self.cloudLayersV2 = cloudLayersV2
        self.weather = weather
        self.visibility = visibility
        self.wind = wind
        self.period = period
        self.turbulence = turbulence
        self.icing = icing
    }
}

class TentacledVisibility: Codable {
    let distanceSm: Double
    let distanceQualifier: Int
    
    init(distanceSm: Double, distanceQualifier: Int) {
        self.distanceSm = distanceSm
        self.distanceQualifier = distanceQualifier
    }
}

class ReportWindsAloft: Codable {
    let lat, lon: Double
    let dateIssued: String
    let windsAloft: [WindsAloftElement]
    let source: String
    
    init(lat: Double, lon: Double, dateIssued: String, windsAloft: [WindsAloftElement], source: String) {
        self.lat = lat
        self.lon = lon
        self.dateIssued = dateIssued
        self.windsAloft = windsAloft
        self.source = source
    }
}

class WindsAloftElement: Codable {
    let validTime: String
    let period: Period
    let windTemps: [String: WindTemp]
    
    init(validTime: String, period: Period, windTemps: [String: WindTemp]) {
        self.validTime = validTime
        self.period = period
        self.windTemps = windTemps
    }
}

class WindTemp: Codable {
    let directionFromTrue, knots, celsius, altitude: Int
    let isLightAndVariable, isGreaterThan199Knots, turbulence, icing: Bool
    
    init(directionFromTrue: Int, knots: Int, celsius: Int, altitude: Int, isLightAndVariable: Bool, isGreaterThan199Knots: Bool, turbulence: Bool, icing: Bool) {
        self.directionFromTrue = directionFromTrue
        self.knots = knots
        self.celsius = celsius
        self.altitude = altitude
        self.isLightAndVariable = isLightAndVariable
        self.isGreaterThan199Knots = isGreaterThan199Knots
        self.turbulence = turbulence
        self.icing = icing
    }
}
