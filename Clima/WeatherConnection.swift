//
//  WeatherConnection.swift
//  Clima
//
//  Created by Minh Tú on 22/9/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation
import Alamofire


class WeatherConnection {
    // URL: https://api.darksky.net/forecast/95cb8ab439d0f26ad1a2f0ad57230228/37.8267,-122.4233
    let WeatherAPIKey: String
    let BaseURL: URL?
    
    init(APIKey: String) {
        self.WeatherAPIKey = APIKey
        self.BaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherDataModel?) -> Void) {
        if let forecastURL = URL(string: "\(BaseURL!)/\(latitude),\(longitude)") {
            Alamofire.request(forecastURL).responseJSON { (response) in
                
                print(response)
                print("*******")
                print(response.result)
                if(response.result.isSuccess){
                    if let jsonDict = response.result.value as? [String: Any] {
                        if let currentWeatherDict = jsonDict["currently"] as? [String : Any] {
                            let currentWeather = WeatherDataModel(weatherDictionary: currentWeatherDict)
                            completion(currentWeather)
                        } else {
                            completion(nil)
                        }
                    }
                } else {
                    print("Error: \(response.result.error)")
                }
            }
        }
    }
    
    
}
