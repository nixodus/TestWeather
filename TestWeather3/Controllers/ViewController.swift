//
//  ViewController.swift
//  TestWeather3
//
//  Created by Nicholas Piotrowski on 17/12/2018.
//  Copyright © 2018 Nicholas Piotrowski. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON






class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "54c0bc2bd55d5c5153fad6e2bcd78c0d"
    
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        

        
    }

    
    func getWeatherData(url: String, parameters : [String : String]){
        
        //print(parameters)
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess{
                //print("Succes get weather data \(String(describing: response.data))")
                let weatherJSON : JSON = JSON(response.result.value!)
                //print(weatherJSON);
                self.updateWeatherData(json: weatherJSON)
                
            }else{
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
            
        }
        
    }
    
    
    func updateWeatherData(json : JSON){
        
        //print(json)
        
        if  let tempResult = json["main"]["temp"].double{
            weatherDataModel.temperature = Int(tempResult - 273.15);
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            weatherDataModel.temperatureMin = Int(json["main"]["temp_min"].doubleValue - 273.15);
            weatherDataModel.temperatureMax = Int(json["main"]["temp_max"].doubleValue - 273.15);
            weatherDataModel.weatherConditionLabel = json["weather"][0]["description"].stringValue;
            
            updateUIWithWeatherData()
            
        }else{
            cityLabel.text = "Weather unavailable"
        }
        
    }
    
    
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature)+"℃"
        temperatureMinLabel.text = String(weatherDataModel.temperatureMin)+"℃"
        temperatureMaxLabel.text = String(weatherDataModel.temperatureMax)+"℃"
        descLabel.text = String(weatherDataModel.weatherConditionLabel)
        
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            //print("latitude: \(location.coordinate.latitude)  longitude: \(location.coordinate.longitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params);
        }
        
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
        cityLabel.text = "Location Unavilable"
    }
    
    
    
    


}

