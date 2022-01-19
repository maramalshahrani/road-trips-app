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
    var adsImages: [String] = []

    var filterVaction: [Vaction] = []
    var allVaction: [Vaction] = []
    let search = UISearchController()
    
    public func setupSearchBar() {
        
        search.loadViewIfNeeded()// Loads the view controller’s view if it has not yet been loaded.
        search.searchResultsUpdater = self // object responsible for updating the contents of the search results controller.
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.returnKeyType = .done
        search.searchBar.sizeToFit()
        search.searchBar.placeholder = NSLocalizedString("Search for a city", comment: "")
        search.hidesNavigationBarDuringPresentation = false //A Boolean indicating whether the navigation bar should be hidden when searching.
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
        
        //
        self.adsImages.removeAll()
        Database.database().reference().child("Ads").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get Category value
            let value = (snapshot.value as? NSDictionary)?.allValues
        if value != nil {
        for curentAds in value!{
            let value = (curentAds as? NSDictionary)
                let image = value?["image"] as? String ?? ""
            self.adsImages.append(image)
            
            }
        }

        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForHeaderIn section: Int) -> CGFloat {
        return 230
    }
    
    func collectionView(
     _ collectionView: UICollectionView,
     viewForSupplementaryElementOfKind kind: String,
     at indexPath: IndexPath
   ) -> UICollectionReusableView {
     switch kind {
     // 1
     case UICollectionView.elementKindSectionHeader:
       // 2
       let headerView = collectionView.dequeueReusableSupplementaryView(
         ofKind: kind,
         withReuseIdentifier: "\(adsSliderCVCell.self)",
         for: indexPath)

       // 3
       guard let typedHeaderView = headerView as? adsSliderCVCell
       else { return headerView }

       // 4

         typedHeaderView.imagesArray = self.adsImages
         typedHeaderView.reloadContent()
       return typedHeaderView
     default:
       // 5
       assert(false, "Invalid element type")
     }
   }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.allVaction.removeAll()
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
                    let activeCovid = value?["activeCovid"] as? String ?? ""
                    let rate = value?["rate"] as? String ?? ""
                    let rateCount = value?["rateCount"] as? String ?? ""
                    
                    self.allVaction.append(Vaction.init(id: id, image: image, title: title, desc: desc, lat: lat, lang: lang , activeCovid: activeCovid, rateCount: rateCount , rate: rate, title_ar: title_ar , desc_ar: desc_ar))
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
        collectionView.register(adsSliderCVCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: adsSliderCVCell.identifier)

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
        self.collectionView.reloadData()
        if !text.isEmpty {
            filterVaction = allVaction.filter{$0.title.lowercased().contains(text.lowercased()) }
            collectionView.reloadData()
        }else{
            collectionView.reloadData()
        }
    }
    
}
