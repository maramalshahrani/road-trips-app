//
//  ProfileVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 26/05/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SafariServices
class ProfileVC: UITableViewController {
    
    var curentUser : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        navigationItem.title = NSLocalizedString("Settings", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.backgroundColor = UIColor.systemGray6
        self.tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Auth.auth().addStateDidChangeListener { [self] (auth, user) in
            if user != nil {
                let userId =  user?.uid ?? ""
                
                //Get specific document from current user
                let docRef = Firestore.firestore()
                    .collection("users")
                    .document(userId)
                
                // Get data
                docRef.getDocument { (document, error) in
                    guard let document = document, document.exists else {
                        print("Document does not exist")
                        return
                    }
                    
                    let dataDescription = document.data()
                    let user_id = dataDescription?["userID"] as? String ?? ""
                    let name = dataDescription?["name"] as? String ?? ""
                    let email = dataDescription?["email"] as? String ?? ""
                    let avatar = dataDescription?["avatar"] as? String ?? ""
                    let phoneNumber = dataDescription?["phoneNumber"] as? String ?? ""
                    
                    self.curentUser = User(id: user_id, name: name , phoneNumber: phoneNumber, email: email, avatar: avatar)
                    self.tableView.reloadData()
                    
                }
            }else{
                self.tableView.reloadData()

            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 6
            
        default:
            print("default")
            return 0
        }
    }
    @objc func goToEditProfile(_ sender : UIButton){
        
        navigationController?.pushViewController(EditProfileVC(), animated: true)
        
    }
    @objc func logoutAction(_ sender : UIButton){
        
        do{
            try Auth.auth().signOut()
            let viewController = GreatingVC()
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            
            sceneDelegate!.window = UIWindow(frame: UIScreen.main.bounds)
            
            sceneDelegate!.window?.rootViewController = UINavigationController(rootViewController: viewController)
            sceneDelegate!.window?.makeKeyAndVisible()
            sceneDelegate!.window?.windowScene = windowScene
            
        }catch{
            print("Error while signing out!")
        }
    }
    @objc func logInAction(_ sender : UIButton){
        
        
        let vc = GreatingVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            
            cell.editPrrofile.addTarget(self, action: #selector(goToEditProfile(_:)), for: .touchUpInside)
            
            
            if Auth.auth().currentUser != nil {
                
                cell.userImageView.backgroundColor = UIColor.systemGray3
                
                if curentUser != nil {
                    if curentUser!.avatar != ""
                    {
                        let url = URL(string: curentUser!.avatar!)
                        cell.userImageView.sd_setImage(with: url, placeholderImage: UIImage(), options: .refreshCached, completed: nil)
                    }
                    cell.userNameLbl.text = curentUser!.name
                    cell.editPrrofile.isHidden = false
                }else{
                    cell.userImageView.backgroundColor = UIColor.systemGray3
                    cell.editPrrofile.isHidden = true
                    
                    cell.userNameLbl.text = "Guest"
                }
                
                cell.logInOut.setTitle(NSLocalizedString("Log Out", comment: ""), for: .normal)

                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.logInOut.backgroundColor = UIColor(#colorLiteral(red: 0.4353726804, green: 0.5419737697, blue: 0.5150486827, alpha: 1))

                
                cell.logInOut.addTarget(self, action: #selector(logoutAction(_:)), for: .touchUpInside)
                
            }else{
                cell.userImageView.backgroundColor = UIColor.systemGray3
                cell.editPrrofile.isHidden = true
                
                cell.userNameLbl.text = "Guest"
             
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.logInOut.setTitle("Log In", for: .normal)
                cell.logInOut.backgroundColor = UIColor(#colorLiteral(red: 0.5395174623, green: 0.6461284757, blue: 0.6582974195, alpha: 1))

                cell.logInOut.addTarget(self, action: #selector(logInAction(_:)), for: .touchUpInside)
                
            }
            
            
            return cell
            
            
            
            
        case 1:
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("Countries Information", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
            case 1:
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("Favoret Places", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
                
            case 2:
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("Applicaiton language", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
                
            case 3:
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("Applicaiton mode", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
                
                
         
                
            case 4:
                let cell = UITableViewCell()
                cell.textLabel?.text =  NSLocalizedString("Contact a travel representative", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
                
            case 5:
                
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("Go To Almosafer Application", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
                
                
         
                
                
            default:
                print("default")
                return UITableViewCell()
            }
            
            
        default:
            print("default")
            return UITableViewCell()
        }
        
    }
    private func changeLanguage() {
        let alert = UIAlertController(title: "Change Language".localized, message: "Select app language".localized, preferredStyle: .actionSheet)
        
        if Language.current == .arabic {
            alert.addAction(.init(title: "English", style: .default, handler: { (_) in
                Language.current = .english
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                
                sceneDelegate!.window = UIWindow(frame: UIScreen.main.bounds)
                let viewController = TabBarVC()
                sceneDelegate!.window?.rootViewController = UINavigationController(rootViewController: viewController)
                sceneDelegate!.window?.makeKeyAndVisible()
                sceneDelegate!.window?.windowScene = windowScene
                if Language.current == .arabic {
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                    UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
                    
                }else if Language.current == .english{
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                    UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
                    
                }
            }))
        }
        
        if Language.current == .english {
            alert.addAction(.init(title: "عربي", style: .default, handler: { (_) in
                Language.current = .arabic
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                
                sceneDelegate!.window = UIWindow(frame: UIScreen.main.bounds)
                let viewController = TabBarVC()
                sceneDelegate!.window?.rootViewController = UINavigationController(rootViewController: viewController)
                sceneDelegate!.window?.makeKeyAndVisible()
                sceneDelegate!.window?.windowScene = windowScene
                if Language.current == .arabic {
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                    UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
                    
                }else if Language.current == .english{
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                    UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
                    
                }
            }))
        }
        
        alert.addAction(.init(title: "System Default".localized, style: .default, handler: { (_) in
            Language.current = .default
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            
            sceneDelegate!.window = UIWindow(frame: UIScreen.main.bounds)
            let viewController = TabBarVC()
            sceneDelegate!.window?.rootViewController = UINavigationController(rootViewController: viewController)
            sceneDelegate!.window?.makeKeyAndVisible()
            sceneDelegate!.window?.windowScene = windowScene
            if Language.current == .arabic {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
                
            }else if Language.current == .english{
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
                
            }
        }))
        
        alert.addAction(.init(title: "Cancel".localized, style: .cancel, handler: nil))
        
        // alert.popoverPresentationController?.sourceView = sender
        // alert.popoverPresentationController?.sourceRect = sender.frame
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            
   
        case 1:
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(CountryInfo(), animated: true)
                
            case 1:
                navigationController?.pushViewController(Favorite(), animated: true)
           
            case 2:
                changeLanguage()
                
                
            case 3:
                
                if self.traitCollection.userInterfaceStyle == .light {
                    overrideUserInterfaceStyle = .dark
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark
                    }
                }else{
                    overrideUserInterfaceStyle = .light
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light
                    }
                }
                
          

           
                
                
            case 4:
                let phoneNumber =  "+966555960332" // you need to change this number
                let appURL = URL(string: "https://wa.me/\(phoneNumber)")!
                if UIApplication.shared.canOpenURL(appURL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(appURL)
                    }
                }
                
            case 5:
                
                
                let appURL = "https://apps.apple.com/sa/app/almosafer/id928866584"
                       
                    guard let url = URL(string: appURL) else { return }
                    let svc = SFSafariViewController(url: url)
                    present(svc, animated: true, completion: nil)
                
       
                
          
            
        default:
            print("default")
        }
  
        default:
            print("default")
        }
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 240
        default:
            return 60
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
