

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SwiftSky

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    
    let BASE_URL = "https://dataservice.accuweather.com/"
    let weatherLocation = "locations/v1/cities/search?"
    let API_KEY = "apikey=mgVsk0C3MVeSwt9N3St2op81fD7muHmD"
    
    var city: String!
    
    //TODO: Declare instance variables here
//    let locationManager = CLLocationManager()
//    let coordinate: (lat: Double, long: Double) = (lat: 37.3324361277948, long: -122.030861526237)
//    var weatherConnection: WeatherConnection!
    let locationManager = CLLocationManager()
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        /locations/v1/cities/search?apikey=mgVsk0C3MVeSwt9N3St2op81fD7muHmD&q=London HTTP/1.1
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    func getWeatherData(cityName: String) {
    
//        let coordinate = "\(parameters.0),\(parameters.1)"
//        /locations/v1/cities/geoposition/search?apikey=mgVsk0C3MVeSwt9N3St2op81fD7muHmD&q=37.33233141%2C-122.0312186&details=true HTTP/1.1
        let weatherURL = URL(string: "\(BASE_URL)\(weatherLocation)\(API_KEY)&q=\(cityName)")
        print(weatherURL)
        Alamofire.request(weatherURL!).responseJSON { (response) in
            print(response.result)
            let weatherData : JSON = JSON(response.result.value)
            //            weatherData.dictionary
//            print(weatherData[weatherData.count - 1]["Key"])
            print(weatherData)
        }
        
        
        
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //Convert geoposition to location
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            
            print("Here is location: \(location)")
            print(placemarks?.count)
            
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    
    func getPlaceName(location: CLLocation, completion: @escaping (_ answer: String?) -> Void) {
        
//        let coordinates = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with an error " + (error?.localizedDescription)!)
                completion("Error")
            } else if (placemarks?.count)! > 0 {
                let pm = placemarks![0] as CLPlacemark
                completion(self.displayLocationInfo(placemark: pm))
            } else {
                print("Problems with the data received from geocoder.")
                completion("Placemark Errror")
            }
        })
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) -> String
    {
        if let containsPlacemark = placemark
        {
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
           
            print(locality)
        
            return locality!
            
        } else {
            
            return ""
            
        }
        
    }
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]

        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("Longitude: \(location.coordinate.longitude), Latitude: \(location.coordinate.latitude)")

            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            let params = CLLocation(latitude: latitude, longitude: longitude)
            
            var dataDict : [String : String] = ["lat": String(latitude), "long": String(longitude)]
            
            print(params)
            
            
            getPlaceName(location: params) { (answer) in
                print("City is: \(answer!)")
                self.cityLabel.text = "\(answer!)"
                self.getWeatherData(cityName: answer!)
            }
            
            
            
//            getWeatherData(cityName: "Cupertino")

        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Unavailable Location"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


