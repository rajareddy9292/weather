//
//  weatherTests.swift
//  weatherTests
//
//  Created by RajaReddy  on 10/10/2018.
//   Copyright © 2018 AdtechCorp. All rights reserved.
//

import XCTest
@testable import weather

class weatherJSONParsingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        // We are testing with unsafe array operations
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Parsing OpenWeatherMap's Example API response
    func testParseDemoJSON() {
        
        // Data setup
        let jsonString = "{\"city\": {\"id\": 1851632,\"name\": \"Shuzenji\",\"coord\": {\"lon\": 138.933334, \"lat\": 34.966671}, \"country\": \"JP\", \"cod\": \"200\", \"message\": 0.0045, \"cnt\": 38}, \"list\": [{ \"dt\": 1406106000, \"main\": { \"temp\": 298.77, \"temp_min\": 298.77, \"temp_max\": 298.774, \"pressure\": 1005.93, \"sea_level\": 1018.18, \"grnd_level\": 1005.93, \"humidity\": 87, \"temp_kf\": 0.26 }, \"weather\": [ { \"id\": 804, \"main\": \"Clouds\",\"description\": \"overcast clouds\", \"icon\": \"04d\" } ], \"clouds\": { \"all\": 88 }, \"wind\": {\"speed\": 5.71, \"deg\": 229.501 }, \"sys\": { \"pod\": \"d\" }, \"dt_txt\": \"2014-07-23 09:00:00\"}]}"
        
        let data = jsonString.data(using: .utf8)
        let json = try? JSONSerialization.jsonObject(with: data!)
        
        // Collect resulting data
        let weatherDataPoints = ApiHandler.parseWeatherData(json: json)
        
        // Do we have the one object we wanted?
        XCTAssertTrue(weatherDataPoints.count == 1)
        
        // Does it seem to be correctly parsed?
        XCTAssertTrue(weatherDataPoints[0].maxTemperature == 298.774)
        XCTAssertTrue(weatherDataPoints[0].minTemperature == 298.77)
        XCTAssertTrue(weatherDataPoints[0].temperature == 298.77)
        XCTAssertTrue(weatherDataPoints[0].weatherMain == "Clouds")
        XCTAssertTrue(weatherDataPoints[0].weatherDescription == "overcast clouds")
    }
    
    // Parsing an empty API json
    func testParseEmptyString() {
        
        // Data setup
        let jsonString = ""
        let data = jsonString.data(using: .utf8)
        let json = try? JSONSerialization.jsonObject(with: data!)
        
        // Collect resulting data
        let weatherDataPoints = ApiHandler.parseWeatherData(json: json)
        
        // Do we have a zero-length array?
        XCTAssertTrue(weatherDataPoints.count == 0)
    }
    
}
