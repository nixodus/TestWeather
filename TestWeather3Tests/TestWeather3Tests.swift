//
//  TestWeather3Tests.swift
//  TestWeather3Tests
//
//  Created by Nicholas Piotrowski on 17/12/2018.
//  Copyright © 2018 Nicholas Piotrowski. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON

@testable import TestWeather3

class TestWeather3Tests: XCTestCase {
    
var controllerUnderTest: ViewController!
    
    override func setUp() {
        
        super.setUp()
        controllerUnderTest = UIStoryboard(name: "Main",
                                           bundle: nil).instantiateInitialViewController() as! ViewController
    }

    override func tearDown() {
        controllerUnderTest = nil
        super.tearDown()
    }

    func testWeatherModel() {
        
        // 1. given
        
        var testWeatherModel: WeatherDataModel!
        testWeatherModel = WeatherDataModel()
        
        // 2. when
        let testIconName = testWeatherModel.updateWeatherIcon(condition: 400)
        
        // 3. then
        XCTAssertEqual(testIconName, "10d", "Wrong icon name")
        
    }


    
    


}
