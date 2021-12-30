//
//  ProfileCell.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 26/05/1443 AH.
//

import Foundation
import UIKit
import SDWebImage


class ProfileCell: UITableViewCell {

  
        static let identifier = "ProfileCell"
        
         let userImageView: UIImageView = {
            let imagev = UIImageView.init(frame: CGRect.init(x: 10, y: 0, width: 90, height: 90))
            imagev.contentMode = .scaleAspectFill
            imagev.translatesAutoresizingMaskIntoConstraints = false
            imagev.layer.borderWidth = 0.25
            imagev.layer.borderColor = UIColor.init(named: "WhiteColor")!.cgColor
            imagev.clipsToBounds = true
             imagev.layer.cornerRadius = 60
            return imagev
        }()

        
    let editPrrofile: UIButton = {
       let editPrrofile = UIButton.init(frame: CGRect.init(x: 110, y: 90, width: 200, height: 40))
        editPrrofile.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        editPrrofile.tintColor = UIColor(#colorLiteral(red: 0.52037251, green: 0.6478561759, blue: 0.6156760454, alpha: 1))
        editPrrofile.backgroundColor = UIColor.init(named: "BlackColor")
        editPrrofile.translatesAutoresizingMaskIntoConstraints = false
        editPrrofile.clipsToBounds = true
        editPrrofile.layer.cornerRadius = 15

        editPrrofile.tintColor = UIColor.init(named: "WhiteColor")!

       return editPrrofile
   }()
    
         let logInOut: UIButton = {
            let logInOut = UIButton.init(frame: CGRect.init(x: 110, y: 90, width: 200, height: 30))
             logInOut.backgroundColor = UIColor(#colorLiteral(red: 0.5395174623, green: 0.6461284757, blue: 0.6582974195, alpha: 1))
             logInOut.setTitleColor(UIColor.init(named: "WhiteColor"), for: .normal)
             
             logInOut.translatesAutoresizingMaskIntoConstraints = false
             logInOut.clipsToBounds = true
             logInOut.layer.cornerRadius = 10.0
            return logInOut
        }()
        
         let userNameLbl: UILabel = {
            let labelV = UILabel.init(frame: CGRect.init(x: 110, y: 0, width: 200, height: 30))
            labelV.textColor = UIColor.init(named: "BlackColor")!
            labelV.font = UIFont.systemFont(ofSize: 25, weight: .bold)
             labelV.translatesAutoresizingMaskIntoConstraints = false
            return labelV
        }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
            contentView.addSubview(userImageView)
            contentView.addSubview(userNameLbl)
            contentView.addSubview(logInOut)
        contentView.addSubview(editPrrofile)


            contentView.clipsToBounds = true
           
            
            NSLayoutConstraint.activate([
                userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                userImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                userImageView.widthAnchor.constraint(equalToConstant: 120.0),
                userImageView.heightAnchor.constraint(equalToConstant: 120.0),
                
                
                userNameLbl.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
                userNameLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
              
                            
                logInOut.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 50),
                logInOut.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

                logInOut.widthAnchor.constraint(equalToConstant: 250),
                logInOut.heightAnchor.constraint(equalToConstant: 40),
                
                editPrrofile.topAnchor.constraint(equalTo: userImageView.topAnchor, constant: 10),
                editPrrofile.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: -10),

                editPrrofile.widthAnchor.constraint(equalToConstant: 30.0),
                editPrrofile.heightAnchor.constraint(equalToConstant: 30.0),

            ])
           }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    
        
     
    }
