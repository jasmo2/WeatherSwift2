//
//  ViewController.swift
//  wheaterSwift2
//
//  Created by Jaime Molina Orbe on 1/14/16.
//  Copyright © 2016 jasmo2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBAction func cityButton(sender: UIButton) {
        cityAlert()
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
            print(textField.text!)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

