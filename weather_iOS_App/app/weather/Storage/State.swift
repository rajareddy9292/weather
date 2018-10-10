//
//  State.swift
//  weather
//
//  Created by RajaReddy  on 10/10/2018.
//   Copyright © 2018 AdtechCorp. All rights reserved.
//

import Foundation

class State {
    
    static let sharedInstance = State()
    
    var weatherSamples: [WeatherSample]?

    // This function is to group the samples by their date 
    func groupedWeatherSamples() -> [[WeatherSample]] {

        if (weatherSamples == nil || weatherSamples!.count < 1) {
            return [[]]
        }
        
        // Helper variable to map the samples by their date
        var dict: [String:[WeatherSample]] = [:]
        
        for ws in weatherSamples! {
            let dateKey = ws.dateString(format: "YYYYMMdd")
            if (dict[dateKey] == nil || dict[dateKey]!.count < 1) {
                dict[dateKey] = []
            }
            dict[dateKey]?.append(ws)
        }
        
        var retval: [[WeatherSample]] = []
        
        let sortedKeys = Array(dict.keys).sorted()
        for key in sortedKeys {
            retval.append(dict[key]!)
        }
        
        return retval
    }
    
}
