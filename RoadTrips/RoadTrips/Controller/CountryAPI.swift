//
//  CountryAPI.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 28/05/1443 AH.
//

import Foundation

protocol CountryAPIDelegate {
    func didRetriveCountryInfo(country: Country)
}

class CountryAPI {
    
    var delegate: CountryAPIDelegate?
    let urlBaseString = "https://restcountries.com/v3.1/name/"
    
    //to Use the API link and add to it name of country
    func fetchData(countryName: String) {
        let urlString = "\(urlBaseString)\(countryName)"
        
        // create URL
        let url = URL(string: urlString)!
        
        // create URL session
        let session = URLSession(configuration: .default)
        
        //create Task
        let task = session.dataTask(with: url, completionHandler: taskHandler(data:urlResponse:error:))
        
        //start resum task
        task.resume()
    }
    
    // MARK:- to used inside the Task and process the data before it is used
    func taskHandler(data: Data?, urlResponse: URLResponse?, error: Error?) {
        
        do {
            let countries: [Country] = try JSONDecoder().decode([Country].self, from: data!)
            let firstCountry = countries[0]
            delegate?.didRetriveCountryInfo(country: firstCountry)
        
        }catch {
            print(error)
        }
//        let dataString = String(data: data!, encoding: .utf8)
//        delegate?.didRetriveCountryInfo(countryInfo: dataString)
        
    }

}
