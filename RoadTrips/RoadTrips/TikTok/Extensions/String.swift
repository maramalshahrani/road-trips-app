//
//  String.swift
//  KD Tiktok-Clone
//
//  RoadTrips
//
//  Created by Maram Al shahrani on 19/04/1443 AH.
//

import Foundation

extension String{
    static func format(decimal:Float, _ maximumDigits:Int = 1, _ minimumDigits:Int = 1) ->String? {
        let number = NSNumber(value: decimal)
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumDigits
        numberFormatter.minimumFractionDigits = minimumDigits
        return numberFormatter.string(from: number)
    }
    
}
