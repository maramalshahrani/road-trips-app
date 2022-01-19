//
//  Number.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 13/06/1443 AH.
//

import Foundation

extension Int {
    /**
     * Shorten the number to *thousand* or *million*
     * - Returns: the shorten number and the suffix as *String*
     */
    func shorten() -> String{
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
