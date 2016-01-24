//
//  ViewController.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/14/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import UIKit
import CoreLocation // 1 import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate,WeatherClassDelegate {
    
    let locationManager = CLLocationManager()

    let weatherService = WeatherClass(appid: KeysDict().getOpenWeatherAPIKey())
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBAction func cityButton(sender: UIButton) {
        cityAlert()
    }
    
    func setWeather(weatherStruct: WeatherStruct) {
        print("delegate call")
        print("Town name \(weatherStruct.cityName)")
        print("description: \(weatherStruct.description)")
        print("Temperature en Celcius: \(weatherStruct.kelvin - 273.15)º")
        self.townLabel.text = weatherStruct.cityName
        self.temp.text = "\(String(format: "%.1f", weatherStruct.kelvin - 273.15)) ºC"
        self.descrip.text = weatherStruct.description
        self.weatherImage.image = UIImage(named:  weatherStruct.img)

    }
    func weatherErrorMessage(message: String) {
        let errAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil)
       
        errAlert.addAction(ok)
        
        self.presentViewController(errAlert, animated: false, completion: nil)
    }
    func cityAlert(){
        let alert = UIAlertController(
            title: "Town Alert",
            message: "Enter a Town name",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        
        let cancelAlert = UIAlertAction(
            title: "CLOSE",
            style: UIAlertActionStyle.Cancel,
            handler: nil
        )

        
    
        alert.addAction(cancelAlert)
    
        
        let okAlert = UIAlertAction(title: "OKAY", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            let textField = alert.textFields![0]
            //
            print(textField.text!)
            self.weatherService.getWeatherForCity(textField.text!)
        }
        
        
        alert.addAction(okAlert)
        
        
        alert.addTextFieldWithConfigurationHandler { (textFieldVar: UITextField) -> Void in
            textFieldVar.placeholder = "Enter the city name"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
//   Location delegates 
    func getGPSLocation() {
        print("Starting location Manager")
        locationManager.startUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        // Get weather for location
        print("Did update To Location")
        print(newLocation)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did update locations")
        print(locations)
        self.weatherService.getWeatherForLocation(locations[0])
        locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location error \(error) \(error.userInfo)")
    }
    
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherService.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        self.getGPSLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

