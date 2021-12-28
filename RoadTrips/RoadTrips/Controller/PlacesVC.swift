//
//  PlacesVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 20/05/1443 AH.
//

import UIKit
import FirebaseDatabase
import CHTCollectionViewWaterfallLayout

class PlacesVC: UIViewController {
    
    var collectionView: UICollectionView!
    
    var filterVaction: [Vaction] = []
    var allVaction: [Vaction] = []
    let search = UISearchController ()
    
    public func setupSearchBar() {
        
        search.loadViewIfNeeded()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.returnKeyType = .done
        search.searchBar.sizeToFit()
        search.searchBar.placeholder = NSLocalizedString("Search for a city", comment: "")
        search.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = true
        search.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        self.title = NSLocalizedString("Cities", comment: "")
        view.backgroundColor = .systemGray6
        collectionView.backgroundColor = .systemGray6
        setupSearchBar()
        getData()
        
    }
    func getData(){
        let ref = Database.database().reference()
        // get category
        ref.child("Places").observeSingleEvent(of: .value) { snapshot in
            let value = (snapshot.value as? NSDictionary)?.allValues
            if value != nil {
                for curentVaction in value!{
                    
                    let value = (curentVaction as? NSDictionary)
                    let id = value?["id"] as? String ?? ""
                    let title = value?["title"] as? String ?? ""
                    let image = value?["image"] as? String ?? ""
                    let desc = value?["desc"] as? String ?? ""
                    let lat = value?["lat"] as? String ?? ""
                    let lang = value?["lang"] as? String ?? ""
                    let title_ar = value?["title_ar"] as? String ?? ""
                    let desc_ar = value?["desc_ar"] as? String ?? ""
                    self.allVaction.append(Vaction.init(id: id, image: image, title: title, desc: desc, lat: lat, lang: lang , title_ar: title_ar , desc_ar: desc_ar))
                }
            }
            self.collectionView.reloadData()
            
        }
    }
    private func configureCollectionView(){
        let layoutQustom = CHTCollectionViewWaterfallLayout()
        layoutQustom.itemRenderDirection = .leftToRight
        layoutQustom.columnCount = 2
        
        collectionView                      = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: layoutQustom)
        
        
        collectionView.autoresizingMask     = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate             = self
        collectionView.dataSource           = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CityCell.self, forCellWithReuseIdentifier: CityCell.ID)
        view.addSubview(collectionView)
    }
}

extension PlacesVC: UICollectionViewDelegate , UICollectionViewDataSource , CHTCollectionViewDelegateWaterfallLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filterVaction.count != 0 {
            return filterVaction.count
        }else{
            return allVaction.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.ID, for: indexPath) as! CityCell
        
        if filterVaction.count != 0 {
            cell.setCell(card: filterVaction[indexPath.row])
        }else{
            cell.setCell(card: allVaction[indexPath.row])
            
        }
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC()
        if filterVaction.count != 0 {
            
            vc.curentModel = filterVaction[indexPath.row]
        }else{
            vc.curentModel = allVaction[indexPath.row]
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.frame.size.width/2,
            height: 300
        )
    }
    
}

extension PlacesVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        
        let searchBar = search.searchBar
        
        if let userEnteredSearchText = searchBar.text {
            findResultsBasedOnSearch(with: userEnteredSearchText)
        }
    }
    
    private func findResultsBasedOnSearch(with text: String)  {
        filterVaction.removeAll()
        if !text.isEmpty {
            filterVaction = allVaction.filter{$0.title.lowercased().contains(text.lowercased()) }
            collectionView.reloadData()
        }else{
            collectionView.reloadData()
        }
    }
    
}
