//
//  MapVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 25/05/1443 AH.
//

import Foundation
import MapKit
import FirebaseDatabase
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class Maps: UIViewController, MKMapViewDelegate {
    var selectedPin:MKPlacemark? = nil

    lazy var mapview : MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.delegate = self
        return mv
    } ()
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapview)
        NSLayoutConstraint.activate([
            mapview.topAnchor.constraint(equalTo: view.topAnchor),
            mapview.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapview.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
        ])
        //
        let locationSearchTable = LocationSearchTable()
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapview
        locationSearchTable.handleMapSearchDelegate = self

//
        let ref = Database.database().reference()
        // get images
        var places = [CLLocationCoordinate2D]()
        ref.child("Places").observeSingleEvent(of: .value) { snapshot in
            let value = (snapshot.value as? NSDictionary)?.allValues
            if value != nil {
                for curentVaction in value!{
//
                    let value = (curentVaction as? NSDictionary)
                    let lat = value?["lat"] as? String ?? ""
                    let lang = value?["lang"] as? String ?? ""
                    let title = value?["title"] as? String ?? ""
                    let id = value?["id"] as? String ?? ""

                    let curentLocaion = MKPointAnnotation()
                    curentLocaion.title = title
                    curentLocaion.coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0 , longitude: Double(lang) ?? 0.0)
                    self.mapview.addAnnotation(curentLocaion)
                    places.append(CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0 , longitude: Double(lang) ?? 0.0))
                    //
                    ref.child("Places").child(id).child("images").observeSingleEvent(of: .value) { snapshot in
                        let value = (snapshot.value as? NSDictionary)?.allValues
                        if value != nil {
                            for curentVaction in value!{
                                
                                let value = (curentVaction as? NSDictionary)
                              
                                
                                let langImage = value?["lang"] as? String ?? ""
                                let latImage = value?["lat"] as? String ?? ""
                                let nameImage = value?["name"] as? String ?? ""

                                let curentLocaionImage = MKPointAnnotation()
                                curentLocaionImage.title = nameImage
                                curentLocaionImage.coordinate = CLLocationCoordinate2D(latitude: Double(latImage) ?? 0.0 , longitude: Double(langImage) ?? 0.0)
                                self.mapview.addAnnotation(curentLocaionImage)
                                places.append(CLLocationCoordinate2D(latitude: Double(latImage) ?? 0.0 , longitude: Double(langImage) ?? 0.0))
                                
                                
                            }
                            
                        }
                    }
                    
                }
                var i = 0
                UIView.animate(withDuration: 0.3, delay: 0, options: [.repeat, .autoreverse], animations: {
                    
                    
                    
                    //Animations
                    let region = MKCoordinateRegion(center: places[i], span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
                    self.mapview.setRegion(region, animated: true)
                    
                    i = i + 1
                    
                }, completion: nil)
                
             
                
            }
            
        }
    }
}





extension Maps: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
//        mapview.removeAnnotations(mapview.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
//        mapview.addAnnotation(annotation)

        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapview.setRegion(region, animated: true)
    }
}
