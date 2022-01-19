//
//  TabBarVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 20/05/1443 AH.
//

import UIKit



class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            barItem(tabBarTitle:NSLocalizedString("places", comment: "") , tabBarImage: UIImage(systemName: "paperplane.fill")!.withTintColor(UIColor(#colorLiteral(red: 0.5328342915, green: 0.7127938271, blue: 0.7465521097, alpha: 1)), renderingMode: .alwaysOriginal), viewController: PlacesVC()),
            
            barItem(tabBarTitle:NSLocalizedString("Explorers", comment: "") , tabBarImage: UIImage(systemName: "person.3.fill")!.withTintColor(UIColor(#colorLiteral(red: 0.5328342915, green: 0.7127938271, blue: 0.7465521097, alpha: 1)), renderingMode: .alwaysOriginal), viewController: TouristExplorers()),
            
            
            
            
            barItem(tabBarTitle: NSLocalizedString("Vedios", comment: "") , tabBarImage: UIImage(systemName: "video.fill")!.withTintColor(UIColor(#colorLiteral(red: 0.5328342915, green: 0.7127938271, blue: 0.7465521097, alpha: 1)), renderingMode: .alwaysOriginal), viewController: HomeViewController()),
            
            barItem(tabBarTitle:NSLocalizedString("maps", comment: "") , tabBarImage: UIImage(systemName: "mappin.and.ellipse")!.withTintColor(UIColor(#colorLiteral(red: 0.5328342915, green: 0.7127938271, blue: 0.7465521097, alpha: 1)), renderingMode: .alwaysOriginal), viewController: Maps()),
            
            barItem(tabBarTitle:NSLocalizedString("Settings", comment: "") , tabBarImage: UIImage(systemName: "personalhotspot.circle")!.withTintColor(UIColor(#colorLiteral(red: 0.5328342915, green: 0.7127938271, blue: 0.7465521097, alpha: 1)), renderingMode: .alwaysOriginal), viewController: ProfileVC())
            
            
        ]
        
        tabBar.backgroundColor = UIColor.init(named: "BlackColor")!.withAlphaComponent(0.7)
        tabBar.isTranslucent = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], for: .selected)
        tabBar.unselectedItemTintColor = UIColor.systemGray
        
        selectedIndex   = 0
    }
    
    private func barItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        if tabBarTitle == NSLocalizedString("Vedios", comment: "")  {
            
            let navCont = BaseNavigationController(rootViewController: viewController)
            navCont.tabBarItem.title = tabBarTitle
            navCont.tabBarItem.image = tabBarImage
            navCont.navigationBar.prefersLargeTitles = true
            return navCont
        }else{
            let navCont = UINavigationController(rootViewController: viewController)
            navCont.tabBarItem.title = tabBarTitle
            navCont.tabBarItem.image = tabBarImage
            navCont.navigationBar.prefersLargeTitles = true
            return navCont
        }
    }
    
}
