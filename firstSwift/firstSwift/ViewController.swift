//
//  ViewController.swift
//  firstSwift
//
//  Created by CHAIN on 2016/3/8.
//  Copyright © 2016年 CHAIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate{
    
    let weatherService = WeatherService()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    @IBAction func setCityTapped(sender: UIButton) {
        openCityAlert()
    }
    
    func openCityAlert(){
        //Create Alert Controller
        let alert = UIAlertController(title: "City", message: "Enter City Name", preferredStyle: UIAlertControllerStyle.Alert)
        //Create Cancel Action
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancel)
        //Create OK Action
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            print("OK")
            let textField = alert.textFields?[0]
            print(textField?.text)
            self.cityLabel.text = textField?.text!
            let cityName = textField?.text
            self.weatherService.getWeather(cityName!)
            
        }
        alert.addAction(ok)
        //Add text field
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            textField.placeholder = "City Name"
            
        }
        
        //present Alert Controller
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Weather Service Delegate
    func setWeather(weather: Weather) {
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        let c = formatter.stringFromNumber(weather.tempC)
        
        cityLabel.text = weather.cityName
        tempLabel.text = "\(c!)°C"
        
        descriptionLabel.text = weather.description
        cityButton.setTitle(weather.cityName, forState: .Normal)
        cloudsLabel.text = "Clouds:\(weather.clouds)%"
    }
    
    func weatherErrorWithMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok)
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

