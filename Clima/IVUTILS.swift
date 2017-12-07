//
//  IVUTILS.swift
//  Clima
//
//  Created by Larry Nickerson on 12/5/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import Foundation

// MARK: Temperature Conversions
func fahrenheitFromCelsius (_ celsiusDegrees:Double) -> Double {
    return (celsiusDegrees * (9.0/5.0)) + 32
    
}

func celsiusFromKelvin(_ kelvinDegrees:Double) -> Double {
    return kelvinDegrees - 273.15
}

func farenheitFromKelvin(_ kelvinDegrees: Double) -> Double {
    let celsiusDegrees = celsiusFromKelvin(kelvinDegrees)
    return fahrenheitFromCelsius(celsiusDegrees)
}
