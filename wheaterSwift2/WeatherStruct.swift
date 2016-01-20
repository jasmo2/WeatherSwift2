//
//  WeatherStruct.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/16/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import Foundation

struct WeatherStruct {
    let cityName: String
    let description : String
    let kelvin: Double
    let img: String
    
    init (cityName: String,img: String, description: String, kelvin: Double){
        self.cityName = cityName
        self.description = description
        self.kelvin = kelvin
        self.img = img
        
    }
    
    
    
}