//
//  WeatherService.swift
//  firstSwift
//
//  Created by CHAIN on 2016/3/10.
//  Copyright © 2016年 CHAIN. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate{
    func setWeather(weather: Weather)
    func weatherErrorWithMessage(Message: String)
}

class WeatherService{
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather(city:String){
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let appid = "1cf27bc3e84513b3ff9b5cf5650ca6ad"
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=\(appid)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse{
                print("******")
                print(httpResponse.statusCode)
                print("******")
            }
            
            let json = JSON(data: data!)
            print(json)
            
            var status = 0
            if let cod = json["cod"].int{
                status = cod
            }else if let cod = json["cod"].string{
                status = Int(cod)!
            }
            print("Weather Status Code:\(status)")
            
            if status == 200{
                //OK
                let lon = json["coord"]["lon"].double
                let lat = json["coord"]["lat"].double
                let temp = json["main"]["temp"].double
                let name = json["name"].string
                let desc = json["weather"][0]["description"].string
                let clouds = json["clouds"]["all"].double
                print("Lat:\(lat!) Lon:\(lon!) Temp:\(temp!)")
                
                let weather = Weather(cityName: name!, temp: temp!, description: desc!, clouds: clouds!)
                
                if self.delegate != nil{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.setWeather(weather)
                    })
                }

            }else if status == 404{
                //City cant found
                if self.delegate != nil{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.weatherErrorWithMessage("City not found")
                    })
                }
            }else{
                //other
                if self.delegate != nil{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.weatherErrorWithMessage("Something went wrong")
                    })
                }
            }
            
            
        }

        task.resume()
       
        
        
    //  print("weather Service City: \(city)")
        //request weather data
        //wait...
        //process data
    /*    let weather = Weather(cityName: city, temp: 237.12, description: "A Nice Day")
        
        if delegate != nil{
            delegate?.setWeather(weather)
      }
*/
    }
}