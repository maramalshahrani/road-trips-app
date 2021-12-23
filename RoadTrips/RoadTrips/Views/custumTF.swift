//
//  custumTF.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 19/05/1443 AH.
//

import UIKit

extension UITextField{
    
    open func setupTF (with placeholder:NSAttributedString){
        backgroundColor = .clear
        autocorrectionType = .no
        layer.cornerRadius = 20
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray6.cgColor
        clipsToBounds = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        attributedPlaceholder = placeholder
        tintColor = UIColor.init(named: "WhiteColor")!
        textColor = UIColor.init(named: "WhiteColor")!
    }
}
