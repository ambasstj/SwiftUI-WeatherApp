//
//  WeatherData.swift
//  SwiftUI-Weather
//
//  Created by Tevin Jones on 11/7/23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
struct Coord: Codable{
    let lon: Float
    let lat: Float
}
