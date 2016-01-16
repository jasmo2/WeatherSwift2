//
//  WheaterClass.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/15/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import Foundation
protocol WeatherClassDelegate{
    func setWeather(weatherStruct: WeatherStruct)
    
}


class WeatherClass {
    
    var delegate: WeatherClassDelegate?
    func getWeather(city: String){
        let weather = WeatherStruct(cityName: city, description: "A brief description", kelvin: 293.15)

        if delegate != nil{
            delegate?.setWeather(weather)
        }
    }
}