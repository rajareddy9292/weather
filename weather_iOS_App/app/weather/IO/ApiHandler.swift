//
//  ApiHandler.swift
//  weather
//
//  Created by RajaReddy  on 10/10/2018.
//   Copyright © 2018 AdtechCorp. All rights reserved.
//

import Foundation

class ApiHandler {
    
    /**
     Download weather forecast data
     */
    
    class func getForecast(_ completionHandler: @escaping (Int, Error?) -> Void) {
        
        var apiKey: String?
        
        apiKey = "ab03debe90f375b2fd090e1186949101"
        // If key is still nil here, let's make sure we don't crash while
        // assembling the url
        apiKey = apiKey == nil ? "" : apiKey!
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?id=1269843&APPID=\(apiKey!)"
        
        HttpHandler.sendGetRequest(url: url) { (json, error) -> Void in

            if (error == nil && json != nil) {
                
                // The parsed data looks good; let's save it in the
                // session variable now
                let weatherSamples = ApiHandler.parseWeatherData(json: json!)
                
                State.sharedInstance.weatherSamples = weatherSamples
                
                completionHandler(200, nil)

            } else {
                completionHandler(-1, error)
            }
        }
        
    }
    
    class func parseWeatherData(json: Any) -> [WeatherSample] {
        var weatherDataPoints: [WeatherSample] = []
        
        if let dict = json as? NSDictionary {
            
            if let list = dict["list"] as? [[String:AnyObject]] {
                
                for a in list {
                    let weather = WeatherSample()
                    
                    let main = a["main"] as? [String:AnyObject]
                    let weatherInfo = a["weather"] as? [[String:AnyObject]]
                    
                    weather.timestamp = a["dt"] as? Int
                    weather.temperature = main?["temp"] as? Float
                    weather.minTemperature = main?["temp_min"] as? Float
                    weather.maxTemperature = main?["temp_max"] as? Float
                    
                    if (weatherInfo != nil && weatherInfo!.count > 0) {
                        weather.weatherDescription = weatherInfo?[0]["description"] as? String
                        weather.weatherMain = weatherInfo?[0]["main"] as? String
                    }
                    
                    weatherDataPoints.append(weather)
                }
            }
            
        }
        
        return weatherDataPoints
    }

}
