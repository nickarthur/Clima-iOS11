//
//  WeatherSandboxViewController.swift
//  Clima
//
//  Created by Larry Nickerson on 12/3/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherSandboxViewController: UIViewController, CLLocationManagerDelegate {

    
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "ab024415e180044f32f6646a3a987469"
    
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    
    
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
        //locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // good for nav and food whilst driving
        
        // need to edit the info.plist file and add the following two properties so we get the popups
        // add to info.plist Privacy - "Location When In Use Usage description"
        // add to info.plist Privacy - "Location Usage Description"
        locationManager.requestWhenInUseAuthorization() // this triggers the autorization popup
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    
    
    //Write the didFailWithError method here:
    
    
    
    
    
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
