//
//  WeatherSandboxViewController.swift
//  Clima
//
//  Created by Larry Nickerson on 12/3/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

//BEGIN LEN DEBUG
//END LEN DEBUG
class WeatherSandboxViewController: UIViewController, CLLocationManagerDelegate {

    
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "ab024415e180044f32f6646a3a987469"
    
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    // IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //TODO:Set up the location manager here.
        // lets use this class to serve as the delegate object
        // note we declared that we'll conform to the delegate protocal in the class declaration
        locationManager.delegate = self
        
        // how accurate we want the location to be
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters  // good for weather
//        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // good for nav and food whilst driving
        
        // need to edit the info.plist file and add the following two properties so we get the popups
        // add to info.plist Privacy - "Location When In Use Usage description"
        // add to info.plist Privacy - "Location Usage Description"
        locationManager.requestWhenInUseAuthorization() // this triggers the autorization popup
        
        // kick off the async method to get location updates
        // this runs in background -- will send registered delegate the updates
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String:String]) -> Void {
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: nil).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                
                // here we can force unwrap because we are in success path and have data
                //let weatherJSON : JSON = JSON(response.data!)
                //let weatherJSON : JSON = JSON(response.data as Any) // we could declare the response data as Any
                //let weatherJSON : JSON = JSON(response.result.value!)  // value is same as data
                
                let weatherJSON : JSON = JSON(response.result.value ?? JSON(NSNull()))
                
                // we can copy paste from console to http://www.jsoneditoronline.org
                //print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            }
            else if response.result.isFailure {
                print("request failed: \(String(describing: response.result.error))" )
                self.cityLabel.text = "Connection Issues"
            }
        }
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    
    // best to parse in a separate function and create a DTO to support passing the
    // data around-- e.g. to the UI
    
    func updateWeatherData(json: JSON) {
        
        //swifty json has nice extensions to covert json to other datatypes
        if let tempResult = json["main"]["temp"].double {
            
            // use my IVUTILS temperature conversion functions
            let fahrenheitTemp = Int(farenheitFromKelvin(tempResult))

            weatherDataModel.temperature = fahrenheitTemp
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            // update the screen
            updateUIWithWeatherData()
        }
        else {
            print(json.debugDescription)
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
        //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    // delegate method receives the updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // the last value in the array is the most accurate
        let location = locations[locations.count - 1]
        
        // check the accuracy
        if location.horizontalAccuracy > 0 { // we have a decent location
            
            // SAVE THE USER's PHONE BATTERY
            // since we have a good location, stop updating it
            locationManager.stopUpdatingLocation()
            
            // to prevent making multiple trips to the weather service api
            // once this fires we can unregister the delegat... we can re-register later when we need
            // e.g. if the user types in a different city
            locationManager.delegate = nil
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            // create a dictionary to be sent to the weather service as json
            // an dictionary of string to string key value pairs
            let params : [String : String]  = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
        
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occurred: \(error)")
        cityLabel.text = "Location Unavailable"
        
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    
    
    //Write the PrepareForSegue Method here
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    

}
