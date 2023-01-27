//
//  WeatherDataView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 23/1/2023.
//

import SwiftUI

struct WeatherDataView: View {
    @ObservedObject var data : OurData
    
    @ObservedObject var weatherViewModel : WeatherViewModel
    
    @ObservedObject var weatherForecastViewModel : WeatherForecastViewModel
    
    @ObservedObject var weather10DayViewModel : WeatherForecast10DayViewModel

    
    var body: some View {
        VStack(spacing: 8){
            CustomStackView{
                Label{
                    Text("HOURLY FORECAST")
                        .font(.custom("HelveticaNeue-Medium", size: 13))
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                }
            icon:{
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .padding(.horizontal, 15)
            } contentView: {
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing: 15){
                        ForecastView(time: "Now", celcius: "\(weatherViewModel.temp)", image: weatherViewModel.icon)
                        ForEach(0..<weatherForecastViewModel.forecastList.count, id: \.self) { i in
                            let time = weatherForecastViewModel.forecastList[i].time
                            let sunset = "\(weatherViewModel.sunset.substring(with: 0..<1))\(weatherViewModel.sunset.substring(with: 4..<6))"
                            let sunrise = "\(weatherViewModel.sunrise.substring(with: 0..<1))\(weatherViewModel.sunrise.substring(with: 4..<6))"

                            ForecastView(time: weatherForecastViewModel.forecastList[i].time, celcius: "\(weatherForecastViewModel.forecastList[i].temp)", image: weatherForecastViewModel.forecastList[i].icon)
                            
                            // Display sunrise and sunset after time
                            if(time == sunrise){
                                ForecastView(time: weatherViewModel.sunrise, celcius: "Sunrise", image: "sunrise.fill")
                            }
                            
                            if(time == sunset){
                                ForecastView(time: weatherViewModel.sunset, celcius: "Sunset", image: "sunset.fill")
                            }
                            
                            
                        }
                    }
                }
            }
            
            CustomStackView {
                Label{
                    Text("10-DAY FORECAST")
                        .font(.custom("HelveticaNeue-Bold", size: 15))
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                }
            icon:{
                Image(systemName: "calendar")
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .padding(.horizontal, 15)
            } contentView: {
                VStack(alignment: .leading, spacing: 10){
                    ForEach(0..<weather10DayViewModel.forecast10DayList.count, id: \.self) { index in
                        Forecast10DayView(day: weather10DayViewModel.forecast10DayList[index].day, icon: weather10DayViewModel.forecast10DayList[index].icon, temp_min: weather10DayViewModel.forecast10DayList[index].temp_min, temp_max: weather10DayViewModel.forecast10DayList[index].temp_max)
                    }
                    .frame(maxWidth: .infinity)
                }
                
            }
            
            
            CustomStackView {
                Label{
                    Text("PRECITIPATION")
                        .font(.custom("HelveticaNeue-Medium", size: 13))
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                }
            icon:{
                Image(systemName: "umbrella.fill")
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .padding(.horizontal, 15)
            } contentView: {
                Text("A map will be placed here")
                    .frame(maxWidth: .infinity)
                    .font(.custom("HelveticaNeue-Bold", size: 20))
            }
            
            HStack{
                CustomStackView {
                    Label{
                        Text("UV INDEX")
                            .font(.custom("HelveticaNeue-Medium", size: 13))
                            .foregroundColor(.white)
                            .opacity(0.7)
                        
                    }
                icon:{
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
                .padding(.horizontal, 15)
                } contentView: {
                    VStack(alignment: .leading){
                        Text("0")
                            .font(.custom("HelveticaNeue-Bold", size: 30))
                        Text("Low")
                            .font(.custom("HelveticaNeue-Bold", size: 20))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .infinity)
                
                CustomStackView {
                    Label{
                        Text("SUNRISE")
                            .font(.custom("HelveticaNeue-Medium", size: 13))
                            .foregroundColor(.white)
                            .opacity(0.7)
                        
                    }
                icon:{
                    Image(systemName: "sunrise.fill")
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
                .padding(.horizontal, 15)
                } contentView: {
                    VStack(alignment: .leading){
                        Text(weatherViewModel.sunrise)
                            .font(.custom("HelveticaNeue-Bold", size: 20))
                        Text("Sunset: \(weatherViewModel.sunset)")
                            .font(.custom("HelveticaNeue-Bold", size: 15))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .infinity)
                
            }
            
            
            
        }
    }
}

struct ForecastView: View {
    var time : String
    var celcius : String
    var image : String
    
    var body: some View {
        VStack(){
            Text(time)
                .font(.custom("HelveticaNeue-Medium", size: 13))
            if(image.contains(find: "sunset") || image.contains(find: "sunrise")){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .yellow)
                    .frame(width: 25)
            }
            else if(image.contains(find: "cloud.sun")){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .yellow)
                    .frame(width: 25)
            }
            else if(image.contains(find: "sun")){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.yellow, .white)
                    .frame(width: 25)
            }
            if(image.contains(find: "cloud.rain") || image.contains(find: "cloud.drizzle") || image.contains(find: "cloud.snow")){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .cyan)
                    .frame(width: 25)
            }
            if(image.contains(find: "cloud.fog") || image.contains(find: "cloud.fill")){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white)
                    .frame(width: 25)
            }
            
            Text("\(celcius)°")
                .font(.custom("HelveticaNeue", size: 20))
        }
        .padding(.horizontal, 5)
    }
}

struct Forecast10DayView : View {
    var day : String
    var icon : String
    var temp_min : Int
    var temp_max : Int
    
    var body: some View{
        HStack(spacing: 10){
            Text(day)
                .font(.custom("HelveticaNeue-Medium", size: 18))
                .frame(width: 60, alignment: .leading)
            if(icon.contains(find: "cloud.sun")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .yellow)
                    .frame(width: 30)
            }
            else if(icon.contains(find: "sun")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.yellow, .white)
                    .frame(width: 30)
            }
            if(icon.contains(find: "cloud.rain") || icon.contains(find: "cloud.drizzle") || icon.contains(find: "cloud.snow")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .cyan)
                    .frame(width: 30)
            }
            if(icon.contains(find: "cloud.fog") || icon.contains(find: "cloud.fill")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white)
                    .frame(width: 30)
            }
            
            Text("\(temp_min)°")
                .font(.custom("HelveticaNeue-Medium", size: 18))
            
            ZStack(alignment: .leading){
                Capsule()
                    .fill(.tertiary)
                    .foregroundColor(.white)
                
                GeometryReader{proxy in
                    Capsule()
                        .fill(.linearGradient(.init(colors: [.cyan, .mint]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 20)
                }
            }
            .frame(height: 6)
            
            Text("\(temp_max)°")
                .font(.custom("HelveticaNeue-Medium", size: 18))
        }
    }
    
    
    
}

