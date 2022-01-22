//
//  CountryInfo.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 26/05/1443 AH.
//

import UIKit

class CountryInfo: UIViewController {
    
    var countryAPI = CountryAPI()
    
    var searchTF = UITextField()
    var searchBtn = UIButton()
    var nameCountryLbl = UILabel()
    var startOfWeekLbl = UILabel()
    var nameRegionLbl = UILabel()
    var numpopulationLbl = UILabel()
    var flagLbl = UILabel()
    var imaged = UIImageView()
    
    
    var nameCountry: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemBlue
        return $0
    }(UILabel())
    
    var startOfWeek: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemBlue

        return $0
    }(UILabel())
    
    var nameRegion: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemBlue
        return $0
    }(UILabel())
    
    var populationCount : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemBlue
        return $0
    }(UILabel())
    
    var flag : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemBlue
        return $0
    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        searchTF.delegate = self
        countryAPI.delegate = self
        
        imaged.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imaged)
        imaged.layer.cornerRadius = 40
        imaged.image = UIImage(named: "world")
        NSLayoutConstraint.activate([
            imaged.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            imaged.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            imaged.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            imaged.heightAnchor.constraint(equalToConstant: 220)
        
        ])
        searchTF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchTF)
        searchTF.placeholder = "Type Country"
        searchTF.textAlignment = .center
        searchTF.returnKeyType = .search
        NSLayoutConstraint.activate([
            searchTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            searchTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            searchTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50)
        ])
        
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBtn)
        searchBtn.setImage(UIImage(systemName: "sparkle.magnifyingglass"), for: .normal)
        searchBtn.addTarget(self, action: #selector(searchTbd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            searchBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            searchBtn.leftAnchor.constraint(equalTo: searchTF.rightAnchor, constant: -5)
        ])
        
        view.addSubview(nameCountry)
        NSLayoutConstraint.activate([
            nameCountry.topAnchor.constraint(equalTo: searchTF.bottomAnchor, constant: 20),
            nameCountry.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        nameCountryLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameCountryLbl)
        nameCountryLbl.text = "Country Name"
        NSLayoutConstraint.activate([
            nameCountryLbl.topAnchor.constraint(equalTo: searchTF.bottomAnchor, constant: 20),
            nameCountryLbl.rightAnchor.constraint(equalTo: nameCountry.leftAnchor, constant: -10)
        
        ])
        
        view.addSubview(startOfWeek)
        NSLayoutConstraint.activate([
            startOfWeek.topAnchor.constraint(equalTo: nameCountry.bottomAnchor, constant: 20),
            startOfWeek.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
        startOfWeekLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startOfWeekLbl)
        startOfWeekLbl.text = "Start Of Week"
        NSLayoutConstraint.activate([
            startOfWeekLbl.topAnchor.constraint(equalTo: nameCountryLbl.bottomAnchor, constant: 20),
            startOfWeekLbl.rightAnchor.constraint(equalTo: startOfWeek.leftAnchor, constant: -10)
        ])
        
        view.addSubview(nameRegion)
        NSLayoutConstraint.activate([
            nameRegion.topAnchor.constraint(equalTo: startOfWeek.bottomAnchor, constant: 20),
            nameRegion.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
        nameRegionLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameRegionLbl)
        nameRegionLbl.text = "Region Name"
        NSLayoutConstraint.activate([
            nameRegionLbl.topAnchor.constraint(equalTo: startOfWeekLbl.bottomAnchor, constant: 20),
            nameRegionLbl.rightAnchor.constraint(equalTo: nameRegion.leftAnchor, constant: -10)
        ])
        
        view.addSubview(populationCount)
        NSLayoutConstraint.activate([
            populationCount.topAnchor.constraint(equalTo: nameRegion.bottomAnchor, constant: 20),
            populationCount.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        numpopulationLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numpopulationLbl)
        numpopulationLbl.text = "Population"
        NSLayoutConstraint.activate([
            numpopulationLbl.topAnchor.constraint(equalTo: nameRegionLbl.bottomAnchor, constant: 20),
            numpopulationLbl.rightAnchor.constraint(equalTo: populationCount.leftAnchor, constant: -10)
        ])
        
        view.addSubview(flag)
        NSLayoutConstraint.activate([
            flag.topAnchor.constraint(equalTo: populationCount.bottomAnchor, constant: 20),
            flag.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        flagLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flagLbl)
        flagLbl.text = "Flag"
        flagLbl.textAlignment = .left
        NSLayoutConstraint.activate([
            flagLbl.topAnchor.constraint(equalTo: numpopulationLbl.bottomAnchor, constant: 20),
            flagLbl.rightAnchor.constraint(equalTo: flag.leftAnchor, constant: -10)
        ])
        
    }
    
    @objc func searchTbd() {
        updateUI()
    }
    
    func updateUI() {
        countryAPI.fetchData(countryName: searchTF.text!)

    }

}

//MARK:- For use delegate function to tetxField
extension CountryInfo: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateUI()
        return true
    }
}

extension CountryInfo: CountryAPIDelegate {
    
    func didRetriveCountryInfo(country: Country) {
        print(country)
        
        DispatchQueue.main.async {
            self.nameCountry.text = country.name.common
            self.startOfWeek.text = country.startOfWeek
            self.nameRegion.text = country.region
            self.populationCount.text = String(country.population)
            self.flag.text = country.flag
        }
        
    }
}
