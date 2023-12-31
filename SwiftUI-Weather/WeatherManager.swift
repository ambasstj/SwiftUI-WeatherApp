//
//  WeatherManager.swift
//  SwiftUI-Weather
//
//  Created by Tevin Jones on 11/7/23.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=bc68cc0cf6fd3ec141057a18459720ba&units=imperial&"
    let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?&appid=bc68cc0cf6fd3ec141057a18459720ba&"
    
    //"lat={lat}&lon={lon}"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: Float, longitude: Float) {
        let urlString = "\(forecastURL)lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let parsedObject = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: parsedObject)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, lat: lat, lon: lon)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
