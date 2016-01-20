//
//  Keys.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/18/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import Foundation

class KeysDict {
    var keys: NSDictionary?

    init(){
        if let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
    }
    func getOpenWeatherAPIKey()->String{
        if let _ = keys {
           return keys?["weatherkey"] as! String
           
        }
        return ""
    }
}