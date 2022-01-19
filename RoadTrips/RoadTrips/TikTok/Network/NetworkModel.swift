//
//  NetworkModel.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 13/06/1443 AH.
//

import Foundation

class NetworkModel: NSObject {
    /// Firebase call successfully returns data
    typealias Success = (Any) -> Void
    /// Firebase call fails to return data
    typealias Failure = (Error) -> Void
}

