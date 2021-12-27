//
//  Favorite.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 23/05/1443 AH.
//

import CHTCollectionViewWaterfallLayout
import UIKit
import FirebaseAuth
import FirebaseDatabase

class Favorite: UIViewController  {
    
    var filterVaction: [Vaction] = []
    var allVaction: [Vaction] = []
    
    public func setupSearchBar() {
        
        search.loadViewIfNeeded()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.returnKeyType = .done
        search.searchBar.sizeToFit()
        search.searchBar.placeholder = "Search for a Place"
        search.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = true
        search.searchBar.delegate = self
    }
    
    
    
    let search = UISearchController()
    
    lazy var collectionView: UICollectionView = {
        let layoutQustom = CHTCollectionViewWaterfallLayout()
        layoutQustom.itemRenderDirection = .leftToRight
        layoutQustom.columnCount = 2
        
        let collectionV = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: layoutQustom)
        
        
        //        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(CityCell.self,forCellWithReuseIdentifier: CityCell.ID)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        self.title = "My choices"
        view.backgroundColor = .systemGray
        collectionView.backgroundColor = .systemGray6
        setupSearchBar()
        getData()
        
        //
        
    }
    
    func getData(){
        //
        allVaction.removeAll()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let id_user =  user?.uid ?? ""
                let ref = Database.database().reference()
                // get
                ref.child("Like").child(id_user).observeSingleEvent(of: .value) { snapshot in
                    let value = (snapshot.value as? NSDictionary)?.allValues
                    if value != nil {
                        for curentCategory in value!{
                            
                            let value = (curentCategory as? NSDictionary)
                            let vactionId = value?["vactionId"] as? String ?? ""
                            
                            ref.child("Places").child(vactionId).observeSingleEvent(of: .value, with: { (snapshot) in
                                
                                let value = (snapshot.value as? NSDictionary)
                                if value != nil {
                                    
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
                                self.collectionView.reloadData()
                                
                            })
                        }
                    }
                }
            }else{
                let alert = UIAlertController(title: "Login needed", message: "This feature requires login, please login to your account.", preferredStyle: .alert)
                
                alert.addAction(.init(title: "Login / Signup", style: .default, handler: { (action) in
                    UserDefaults.standard.set(false, forKey: "isShowLoginPrompt")
                    let vc = GreatingVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }))
                
                alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
                UserDefaults.standard.set(true, forKey: "isShowLoginPrompt")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    private func configureCollectionView(){
        
        collectionView.autoresizingMask     = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate             = self
        collectionView.dataSource           = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CityCell.self, forCellWithReuseIdentifier: CityCell.ID)
        view.addSubview(collectionView)
    }
}
private func Layout() -> UICollectionViewCompositionalLayout{
    
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 20, trailing: 18)
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .estimated(300)),subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets.top = 25
    return UICollectionViewCompositionalLayout(section: section)
    
}


extension Favorite: UICollectionViewDelegate , UICollectionViewDataSource , CHTCollectionViewDelegateWaterfallLayout{
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.frame.size.width/2,
            height: 200
        )
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
}
extension Favorite: UISearchResultsUpdating, UISearchBarDelegate {
    
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
