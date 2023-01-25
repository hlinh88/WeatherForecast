//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 20/1/2023.
//

import SwiftUI

@main
struct WeatherApp: App {
    let data = OurData()
    
    init(){
        data.fetchCurrentWeather()
        data.fetchNextHourWeather()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
