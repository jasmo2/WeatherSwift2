//
//  WheaterClass.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/15/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol WeatherClassDelegate{
    func setWeather(weatherStruct: WeatherStruct)
    func weatherErrorMessage(message: String)
    
}


class WeatherClass {
    var delegate: WeatherClassDelegate?
    func getWeather(city: String){

        let cityScape = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let openWeatherAPIKey = Keys()
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityScape!)&appid=2de143494c0b295cca9337e1e96b00e0"
        //(openWeatherAPIKey.getOpenWeatherAPIKey())
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, err: NSError?) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print(httpResponse)
            }
            
            let json = JSON(data: data!)
            print("Is done processing URL")
            
            let name = json["name"].string
            let desc = json["weather"][0]["description"].string
            let temp = json["main"]["temp"].double
            let lat = json["lat"].double
            let log = json["log"].double
            let img = json["weather"][0]["icon"].string
            
            let weather = WeatherStruct(cityName: name!,img: img!, description: desc!, kelvin: temp!)
    
            
            if self.delegate != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                     self.delegate?.setWeather(weather)
                })
            }
        }
        task.resume()
        
       
    }
}