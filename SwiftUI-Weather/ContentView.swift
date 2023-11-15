//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Tevin Jones on 11/5/23.
//

import SwiftUI
import Foundation

struct ContentView: View {

    
    @State private var isNight = false
    @State private var weatherObject: WeatherModel?
    @State var weatherManage = WeatherManager()
    let W = DaysofWeek()
    
    
    var body: some View {
        ZStack{
            BackGroundView(isNight: isNight)
                 .onAppear {
                    weatherManage.delegate = self
                    weatherManage.fetchWeather(cityName: "Gaza")
                }
            VStack{
                
                CurrentCityView(cityName: weatherObject?.cityName ?? "Tevin")
                CurrentWeatherData(imageName: isNight ? "moon.stars.fill":  weatherObject?.conditionName ?? "", temp: Int(weatherObject?.temperature ?? 0.0) )
               
                HStack(spacing: 10){
                    WeatherDayView(index: 1, temp: Int.random(in: 50..<99), imageName: "sun.horizon.fill")
                    WeatherDayView(index: 2, temp: Int.random(in: 50..<99), imageName: "cloud.fill")
                    WeatherDayView(index: 3, temp: Int.random(in: 50..<99), imageName: "sun.max.fill")
                    WeatherDayView(index: 4, temp: Int.random(in: 50..<99))
                    WeatherDayView(index: 5, temp: Int.random(in: 50..<99), imageName: "thermometer.sun.fill")
                }
                Spacer()
                WeatherButton(backgroundColor:isNight ? .black: .white, textColor:isNight ? .customLightBlue: .blue) {
                    self.isNight.toggle()
                    
                }
            
                
                Spacer()
            }
        }
    }}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var imageName : String
    var temp: Int
    var todaysDate = Date()
    let Copy = DaysofWeek()
    let dateFormat = DateFormatter()
    var index: Int
    
    
    
    init(index: Int, temp: Int ,imageName: String = "cloud.fill") {
        dateFormat.dateFormat = "EE"
        let weekdays = Copy.week
        let today = dateFormat.string(from: todaysDate)
        self.imageName = imageName
        self.temp = temp
        let arrIndex = weekdays.firstIndex (of: today) ?? 0
        let dayIndex = (arrIndex + index) % weekdays.count
        self.index = dayIndex
    }
    
    var body: some View {
        VStack(spacing: 1) {
            Text(Copy.week[index])
                .font(.system(size: 30))
                .foregroundStyle(.white)
                .padding(1)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            Text("\(temp)°")
                .font(.system(size: 30))
                .foregroundStyle(.white)
        }
    }
}

struct BackGroundView: View {
    var isNight: Bool
    var body: some View {
        LinearGradient(colors: [isNight ? .gray: .customLightBlue, isNight ? .black: .teal, isNight ? .teal: .customDarkBlue],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

struct CurrentCityView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 31.0))
            .foregroundStyle(.white)
            .padding()
    }
}
struct CurrentWeatherData: View {
    var imageName: String
    var temp: Int
    var body: some View {
        
        VStack(spacing: 3){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:200, height: 200)
            Text("\(temp)")
                .font(.system(size: 70))
                .foregroundStyle(.white)
                .padding(.bottom, 60)
        }
    }
    
    
}


extension ContentView: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
                self.weatherObject = weather
        }
                }
       
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
    
}
