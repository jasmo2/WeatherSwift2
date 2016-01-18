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
        let cityScape = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let openWeatherAPIKey = Keys()
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityScape!)&appid=\(openWeatherAPIKey.getOpenWeatherAPIKey())"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, err: NSError?) -> Void in
            print("Is done processing URL")
            
            let weather = WeatherStruct(cityName: city, description: "A brief description", kelvin: 293.15)
            
            if self.delegate != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                     self.delegate?.setWeather(weather)
                })
            }
        }
        task.resume()
        
       
    }
}