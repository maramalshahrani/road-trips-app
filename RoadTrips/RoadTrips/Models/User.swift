//
//  User.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 20/05/1443 AH.
//

import Foundation

struct User: Codable {
    
    private(set) var id: String
    private(set) var name: String
    private(set) var phoneNumber: String?
    private(set) var email: String
    private(set) var avatar: String?
    
}


