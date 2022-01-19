//
//  BaseNavigationController.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 13/06/1443 AH.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        setNavigationBarHidden(true, animated: false)
    }
    
    

}
