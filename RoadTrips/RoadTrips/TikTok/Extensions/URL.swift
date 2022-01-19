//
//  URL.swift
//  KD Tiktok-Clone
//
//  RoadTrips
//
//  Created by Maram Al shahrani on 19/04/1443 AH.
//

import Foundation

extension URL {
    /// Adds the scheme prefix to a copy of the receiver.
    func convertToRedirectURL(scheme: String) -> URL? {
        var components = URLComponents.init(url: self, resolvingAgainstBaseURL: false)
        let schemeCopy = components?.scheme ?? ""
        components?.scheme = schemeCopy + scheme
        return components?.url
    }
    

}
