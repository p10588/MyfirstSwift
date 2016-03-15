//
//  Weather.swift
//  firstSwift
//
//  Created by CHAIN on 2016/3/10.
//  Copyright © 2016年 CHAIN. All rights reserved.
//

import Foundation
struct Weather{
    let cityName: String
    let temp: Double
    let description: String
    let clouds: Double
    
    var tempC: Double{
        get{
            return temp-273.15
        }
    }
    
    init(cityName: String, temp: Double, description: String , clouds: Double){
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.clouds = clouds
    }
    
}
