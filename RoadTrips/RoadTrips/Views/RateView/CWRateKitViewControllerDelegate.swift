//
//  CWRateKitViewControllerDelegate.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 01/06/1443 AH.
//

import Foundation

public protocol CWRateKitViewControllerDelegate {
    func didChange(rate: Int)
    func didDismiss()
    func didSubmit(rate: Int)
}
