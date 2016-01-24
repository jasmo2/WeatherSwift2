//
//  WeatherClassDelegate.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/23/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import Foundation
protocol WeatherClassDelegate{
    func setWeather(weatherStruct: WeatherStruct)
    func weatherErrorMessage(message: String)
    
}