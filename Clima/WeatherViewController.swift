

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SwiftSky

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //Constants
    
    let BASE_URL = "https://dataservice.accuweather.com/"
    let weatherLocation = "locations/v1/cities/search?"
    let currentWeatherConds = "currentconditions/v1/"
    let hourlyWeatherConds = "forecasts/v1/hourly/12hour/"
    let API_KEY = "apikey=  "
    
    var testData = [["Now", UIImage(named: "cloudy2")!, "21°"],
                    ["11AM", UIImage(named: "cloudy2")!, "21°"],
                    ["12PM", UIImage(named: "cloudy2")!, "21°"],
                    ["13PM", UIImage(named: "cloudy2")!, "21°"],
                    ["14PM", UIImage(named: "cloudy2")!, "21°"],
                    ["15PM", UIImage(named: "cloudy2")!, "21°"],
                    ["16PM", UIImage(named: "cloudy2")!, "21°"],
                    ["17PM", UIImage(named: "cloudy2")!, "21°"],
                    ["18PM", UIImage(named: "cloudy2")!, "21°"],
                    ["19PM", UIImage(named: "cloudy2")!, "21°"],
                    ["20PM", UIImage(named: "cloudy2")!, "21°"],
                    ["21PM", UIImage(named: "cloudy2")!, "21°"]]
    
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
    @IBOutlet weak var CollectionWeatherView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        /locations/v1/cities/search?apikey=mgVsk0C3MVeSwt9N3St2op81fD7muHmD&q=London HTTP/1.1
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionWeatherCellCollectionViewCell
        
        cell.HourLabel.text = testData[indexPath.row][0] as? String
        cell.iconLabel.image = testData[indexPath.row][1] as? UIImage
        cell.tempLabel.text = testData[indexPath.row][2] as? String
        
        return cell
    }
    
    
    
    func retrieveData(url: URL, completion: @escaping ([[String : Any]]) -> Void){
        
        
        Alamofire.request(url).responseJSON { (response) in
            if response.result.isSuccess {
                if let dataset = response.result.value as? [[String : Any]] {
                    completion(dataset)
                }
            } else {
                print("")
            }
        }
    }
    
    func getCityData(cityName: String) {
    
//        let coordinate = "\(parameters.0),\(parameters.1)"
//        /locations/v1/cities/geoposition/search?apikey=mgVsk0C3MVeSwt9N3St2op81fD7muHmD&q=37.33233141%2C-122.0312186&details=true HTTP/1.1
        let weatherURL = URL(string: "\(BASE_URL)\(weatherLocation)\(API_KEY)&q=\(cityName)")
//        Alamofire.request(weatherURL!).responseJSON { (response) in
//            if response.result.isSuccess{
//                let weatherData : JSON = JSON(response.result.value!)
//                print(weatherData[0]["Key"])
//            } else {
//                self.cityLabel.text = "Connection Issues"
//            }
//
//        }
        retrieveData(url: weatherURL!) { (cityData) in
            let cityCode = cityData[0]["Key"]
//            /forecasts/v1/hourly/12hour/332094?apikey=mgVsk0C3MVeSwt9N3St2op81fD7muHmD
            let hourlyWeatherURL = URL(string: "\(self.BASE_URL)\(self.hourlyWeatherConds)\(cityCode!)?\(self.API_KEY)")
            print(hourlyWeatherURL)
            self.retrieveData(url: hourlyWeatherURL!, completion: { (hourlyWeatherData) in
                print(hourlyWeatherData)
            })
            
//            if let data = cityData as? [[String : Any]] {
//                print(data)
//            }
        }
        
        
        
    }        //    GET /currentconditions/v1/328328?apikey=mgVsk0C3MVeSwt9N3St2op81fD7muHmD HTTP/1.1

    func getCurrentConditions(code: String){
    
        let weatherURL = URL(string: "\(BASE_URL)\(currentWeatherConds)\(code)?\(API_KEY)")!
        
        
    
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
    
    func geocode(location: CLLocation, completion: @escaping (CLPlacemark?, Error?) -> ())  {
        CLGeocoder().reverseGeocodeLocation(location) { completion($0?.first, $1) }
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

            let latitude : CLLocationDegrees = location.coordinate.latitude
            let longitude : CLLocationDegrees = location.coordinate.longitude

            var location = CLLocation(latitude: latitude, longitude: longitude)
            
            let params = CLLocation(latitude: latitude, longitude: longitude)
            
            var dataDict : [String : String] = ["lat": String(latitude), "long": String(longitude)]
            
            print(params)
            
            geocode(location: location) { (placemarks, error) in
                guard let placemarks = placemarks, error == nil else {return}
                
                DispatchQueue.main.async {
                    //  update UI here
                    self.getCityData(cityName: placemarks.locality!)
                }
                
            }
        } else {
            self.cityLabel.text = "Connection Issues"
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


