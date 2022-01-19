//
//  TravelApplicationSuggestionsVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 01/06/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SafariServices
//this
class TravelApplicationSuggestionsVC: UITableViewController {
    
    var curentUser : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        navigationItem.title = NSLocalizedString("Travel Suggestion", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.backgroundColor = UIColor.systemGray6
        
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return 3
            
       
    }
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("Almofafer", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
            case 1:
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("Booking.com Travel Deals", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
                
            case 2:
                let cell = UITableViewCell()
                cell.textLabel?.text = NSLocalizedString("طيران وفنادق - Flayin.com", comment: "")
                
                cell.backgroundColor = UIColor.init(named: "WhiteColor")!
                cell.contentView.backgroundColor = UIColor.init(named: "WhiteColor")!
                return cell
                
           
            
            
        default:
            print("default")
            return UITableViewCell()
        }
        
    }
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
  
            case 0:
                
                
                let appURL = "https://apps.apple.com/sa/app/almosafer/id928866584"
                       
                    guard let url = URL(string: appURL) else { return }
                    let svc = SFSafariViewController(url: url)
                    present(svc, animated: true, completion: nil)
            
            
        case 1:
            
            
            let appURL = "https://apps.apple.com/sa/app/booking-com-travel-deals/id367003839"
                   
                guard let url = URL(string: appURL) else { return }
                let svc = SFSafariViewController(url: url)
                present(svc, animated: true, completion: nil)
            
            
        case 2:
            
            
            let appURL = "https://apps.apple.com/sa/app/flyin-com-%D8%B7%D9%8A%D8%B1%D8%A7%D9%86-%D9%88-%D9%81%D9%86%D8%A7%D8%AF%D9%82/id1106268318"
                   
                guard let url = URL(string: appURL) else { return }
                let svc = SFSafariViewController(url: url)
                present(svc, animated: true, completion: nil)
                
       
                
          
            
        default:
            print("default")
        }
  
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
            return 60
        
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
