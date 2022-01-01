//
//  CountryModel.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 28/05/1443 AH.
//

import Foundation

struct Country: Decodable {
    var name: Name
    var startOfWeek:String
    var region: String
    var population: Int
    var flag: String
}

struct Name: Decodable {
    let common: String
}
