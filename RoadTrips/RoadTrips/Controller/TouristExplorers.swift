//
//  TouristExplorers.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 23/05/1443 AH.
//

import UIKit
struct Arr {
    let name: String
    let image: String
    let snapCode: String
}
let Contacts =
[
    Arr(name: "Abdullah Aljumah", image: "e1", snapCode: "s1"),
    Arr(name: "Mishaal ALhuymel", image: "e3", snapCode:  "s3"),
    Arr(name: "BuSalman", image: "e4", snapCode:  "s4"),
    Arr(name: "Busaif Alkaabi", image: "e5", snapCode:  "s5"),
    Arr(name: "Saih Tube", image: "e6", snapCode:  "s6"),
    Arr(name: "Lulu Alkhataf", image: "e7", snapCode:  "s7"),
    Arr(name: "Marwan",image: "e8", snapCode: "s8"),
    Arr(name: "Anas Iskandar", image: "e9", snapCode: "s9"),
]

let a = [UIImage(named: "a"),UIImage(named: "a")]
class TouristExplorers: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Travel Explorers🔎", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //tableView code
        let tabelView = UITableView()
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(Cell.self, forCellReuseIdentifier: "cell")
        tabelView.backgroundColor = UIColor.init(named: "WhiteColor")!
        tabelView.rowHeight = 80
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        //add table to view
        view.addSubview(tabelView)
        // add constraint
        NSLayoutConstraint.activate([tabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tabelView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                    ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let r = Contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.imagecell.image = UIImage(named: r.image)
        cell.namecell.text = r.name
        cell.imagecell.layer.masksToBounds = true
        cell.imagecell.layer.cornerRadius = 40
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = Contacts[indexPath.row]
        let newVC = SnapCode()
        newVC.snapImage.image = UIImage(named: data.snapCode)
        newVC.labelName.text = "Scan:SnapCode"
        newVC.labelCity.text = "From: SaudiArabia🇸🇦"
        present(newVC, animated: true, completion: nil)
    }
    var selectedIndex = -1
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex {
            return 354
        }else {
            return 120
        }
    }
}
//cell class
class Cell: UITableViewCell {
    let imagecell = UIImageView()
    let namecell = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        imagecell.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imagecell)
        NSLayoutConstraint.activate([imagecell.leftAnchor.constraint(equalTo: leftAnchor),
                                     imagecell.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                                     imagecell.heightAnchor.constraint(equalToConstant: 80),
                                     imagecell.widthAnchor.constraint(equalTo: imagecell.heightAnchor,multiplier: 100/100)])
        
        
        namecell.text = "cell"
        namecell.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(namecell)
        
        NSLayoutConstraint.activate(
            [namecell.centerYAnchor.constraint(equalTo: centerYAnchor),
             namecell.leftAnchor.constraint(equalTo: imagecell.leftAnchor , constant: 110),
             
             namecell.heightAnchor.constraint(equalToConstant: 80),
             namecell.trailingAnchor.constraint(equalTo: trailingAnchor , constant: 100)])
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
