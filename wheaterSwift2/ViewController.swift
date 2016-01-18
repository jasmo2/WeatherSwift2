//
//  ViewController.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/14/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherClassDelegate {
    
    
    let weatherService = WeatherClass()
    
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
        self.temp.text = "\(String(format: "%.1f", weatherStruct.kelvin - 253.15)) ºC"
        
        self.descrip.text = weatherStruct.description

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
            self.weatherService.getWeather(textField.text!)
        }
        
        
        alert.addAction(okAlert)
        
        
        alert.addTextFieldWithConfigurationHandler { (textFieldVar: UITextField) -> Void in
            textFieldVar.placeholder = "Enter the city name"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.weatherService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

