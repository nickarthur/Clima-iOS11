//
//  ChangeCitySandboxViewController.swift
//  Clima
//
//  Created by Larry Nickerson on 12/3/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class ChangeCitySandboxViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("CHANGE CITY SANDBOX LOADED".uppercased())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Declare the delegate variable here:
    var delegate : ChangeCityDelegate?
    
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    
    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        print("GET WEATHER PRESSED".uppercased())
        
        //1 Get the city name the user entered in the text field
        let cityName = changeCityTextField.text!
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        // USING "OPTIONAL CHAINING"... if delegate is set then execute otherwise ignore
        // this is an alternative to "Optional Binding"
        delegate?.userEnteredANewCityName(city: cityName)
        
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true, completion: {() in
            print("CHANGE CITY SANDBOX DISMISSED".uppercased())
        })
        
    }
    
    
    
    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        
        print("CHANGE CITY SANDBOX DISMISSED".uppercased())
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
