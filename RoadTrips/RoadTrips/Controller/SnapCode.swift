//
//  SnapCode.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 23/05/1443 AH.
//

import UIKit

class SnapCode: UIViewController{
    var snapImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.init(named: "BlackColor")!
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.layer.borderColor = UIColor(#colorLiteral(red: 0.1263863146, green: 0.1471427083, blue: 0.1646030843, alpha: 1)).cgColor
        image.layer.borderWidth = 5
        return image
    }()
    let labelName: UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        title.textColor = UIColor.init(named: "BlackColor")!
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        return title
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(snapImage)
        view.addSubview(labelName)
        snapImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        snapImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        snapImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        snapImage.widthAnchor.constraint(equalToConstant: 340).isActive = true
        snapImage.heightAnchor.constraint(equalToConstant: 260).isActive = true
        
        labelName.topAnchor.constraint(equalTo: snapImage.bottomAnchor, constant: 80).isActive = true
        labelName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        labelName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
    }
}
