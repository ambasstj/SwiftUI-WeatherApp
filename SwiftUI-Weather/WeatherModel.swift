//
//  WeatherModel.swift
//  SwiftUI-Weather
//
//  Created by Tevin Jones on 11/7/23.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let lat: Float
    let lon: Float
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.dust.fill"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
