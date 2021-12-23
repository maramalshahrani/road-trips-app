//
//  CustomButtons.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 19/05/1443 AH.
//

import UIKit

extension UIButton{
    open func setupButton(with title:String){
        backgroundColor = UIColor(#colorLiteral(red: 0.9549941421, green: 1, blue: 0.962317884, alpha: 1))
        setTitle(title, for: .normal)
        setTitleColor(UIColor.init(named: "BlackColor")!, for: .normal)
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    open func setupButton(using image:String){
        setImage(UIImage(systemName: image)?.withTintColor(.green,renderingMode: .alwaysOriginal),for: .normal)
        backgroundColor = UIColor(#colorLiteral(red: 0.9549941421, green: 1, blue: 0.962317884, alpha: 1))
        layer.borderColor = UIColor.systemPink.cgColor
        
    }
}
