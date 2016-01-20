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
        let openWeatherAPIKey = KeysDict()
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityScape!)&appid=\(openWeatherAPIKey.getOpenWeatherAPIKey())"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, err: NSError?) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print(httpResponse)
                
                //self.delegate?.weatherErrorMessage("No server response")
            }
            
            let json = JSON(data: data!)
            print("Is done processing URL")
            var status:Int = 0;
            
            if let code = json["cod"].string{
                status = Int(code)!
            } else if let code = json["cod"].int {
                status = code
            }
            
            switch status {
            case 200:
                let name = json["name"].string
                let desc = json["weather"][0]["description"].string
                let temp = json["main"]["temp"].double
//                let lat = json["lat"].double
//                let log = json["log"].double
                let img = json["weather"][0]["icon"].string
                
                
                
                let weather = WeatherStruct(cityName: name!,img: img!, description: desc!, kelvin: temp!)
                
                if self.delegate != nil{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.setWeather(weather)
                    })
                }
            case 400:
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.weatherErrorMessage("Bad Request")
                })
                
            case 401:
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.weatherErrorMessage("Unauthorized")
                })
            case 404:
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.weatherErrorMessage("not Found")
                })
            default:
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.weatherErrorMessage("an error has occured")
                })
            }
            
            
            
            
           
    
            
        }
        task.resume()
        
       
    }
}