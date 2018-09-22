

import UIKit

class WeatherDataModel {
    
    

    //Declare your model variables here
    let temperature: Int?
    let humidity: Int?
    let uvIndex: Int?
    let summary: String?
    let icon: String?
    
    struct WeatherKeys {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let uvIndex = "uvIndex"
        static let summary = "summary"
        static let icon = "icon"
    }
    
    init(weatherDictionary: [String: Any]) {
        temperature = weatherDictionary[WeatherKeys.temperature] as? Int
        
        if let humidityPercent = weatherDictionary[WeatherKeys.humidity] as? Double {
            humidity = Int(humidityPercent * 100)
        } else {
            humidity = nil
        }
        
        uvIndex = weatherDictionary[WeatherKeys.uvIndex] as? Int
        summary = weatherDictionary[WeatherKeys.summary] as? String
        icon = weatherDictionary[WeatherKeys.icon] as? String
    }
    
    //This method turns a condition code into the name of the weather condition image
    
//    func updateWeatherIcon(condition: Int) -> String {
//        
//    switch (condition) {
//    
//        case 0...300 :
//            return "tstorm1"
//        
//        case 301...500 :
//            return "light_rain"
//        
//        case 501...600 :
//            return "shower3"
//        
//        case 601...700 :
//            return "snow4"
//        
//        case 701...771 :
//            return "fog"
//        
//        case 772...799 :
//            return "tstorm3"
//        
//        case 800 :
//            return "sunny"
//        
//        case 801...804 :
//            return "cloudy2"
//        
//        case 900...903, 905...1000  :
//            return "tstorm3"
//        
//        case 903 :
//            return "snow5"
//        
//        case 904 :
//            return "sunny"
//        
//        default :
//            return "dunno"
//        }
//
//    }
}
