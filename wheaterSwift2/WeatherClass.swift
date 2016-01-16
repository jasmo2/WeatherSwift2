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
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=2de143494c0b295cca9337e1e96b00e0"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, err: NSError?) -> Void in
            print("Is done processing URL")
        }
        task.resume()
        
        
        let weather = WeatherStruct(cityName: city, description: "A brief description", kelvin: 293.15)

        if delegate != nil{
            delegate?.setWeather(weather)
        }
    }
}