//
//  WeatherDataModel.swift
//  WeatherTest
//
//  Created by Nicholas Piotrowski on 23/01/2018.
//  Copyright © 2018 Nicholas Piotrowski. All rights reserved.
//

import UIKit

class WeatherDataModel {
    
    
    var temperatureMin : Int = 0
    var temperatureMax : Int = 0
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    var weatherConditionLabel : String = ""
    var unixtimeInterval : Double = 0

    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...299 :
            return "11d"
            
        case 300...500 :
            return "10d"
            
        case 501...599 :
            return "09d"
            
        case 600...699 :
            return "13d"
            
        case 700...771 :
            return "02d"
            
        case 772...799 :
            return "11d"
            
        case 800 :
            return "01d"            
            
        case 801...804 :
            return "03d"
            
        case 900...903, 905...1000  :
            return "11d"
            
        case 903 :
            return "13d"
            
        case 904 :
            return "01d"
            
        default :
            return "02d"
        }
        
    }
}
