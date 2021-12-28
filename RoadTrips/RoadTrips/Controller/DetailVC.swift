//
//  DetailVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 20/05/1443 AH.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase
import SDWebImage
import FSPagerView

class DetailVC: UIViewController , FSPagerViewDataSource{
    var curentModel : Vaction!
    
    var allImage = [URL]()
    
    let pagerView: FSPagerView =  {
        let pagerView = FSPagerView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
        
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.automaticSlidingInterval = 3.0
        pagerView.isInfinite = true
        return pagerView
        
        
        
    }()
    let pageControl: FSPageControl =  {
        let pageControl = FSPageControl(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        pageControl.contentHorizontalAlignment = .center
        pageControl.hidesForSinglePage = true
        pageControl.setFillColor(UIColor.lightGray, for: .normal)
        pageControl.setFillColor(UIColor.init(named: "WhiteColor")!, for: .selected)
        //        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return pageControl
    }()
    
    
    private let bTitle: UILabel = {
        let title = UILabel()
        title.textColor     =  UIColor(#colorLiteral(red: 0.3226320446, green: 0.236202091, blue: 0.2579532862, alpha: 1))
        title.font          = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 35, weight: .bold))
        return title
    }()
    private let lCommint: UITextView = {
        let description             = UITextView()
        description.backgroundColor = UIColor.init(named: "WhiteColor")!
        description.textColor       =  UIColor(#colorLiteral(red: 0.4026142359, green: 0.2947920859, blue: 0.3219620883, alpha: 1))
        description.font            = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        
        description.textAlignment   = .left
        
        return description
    }()
    private let bDescription: UILabel = {
        let description             = UILabel()
        description.textColor       =  UIColor(#colorLiteral(red: 0.4026142359, green: 0.2947920859, blue: 0.3219620883, alpha: 1))
        description.font            = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular))
        description.numberOfLines   = 0
        description.textAlignment   = .left
        return description
    }()
    let likeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        return button
    }()
    @objc func likeButtonAction() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let id_user =  user?.uid ?? ""
                
                if self.likeButton.image(for: .normal) == UIImage(systemName: "heart.fill"){
                    
                    self.likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                    //remove image like
                    let ref = Database.database().reference()
                    ref.child("Places").child(self.curentModel.id).child("Like").child(id_user).removeValue()
                    
                    ref.child("Like").child(id_user).child(self.curentModel.id).removeValue()
                }else{
                    self.likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                    
                    // add image like
                    let ref = Database.database().reference()
                    ref.child("Places").child(self.curentModel.id).child("Like").child(id_user).setValue(["id" : id_user])
                    
                    ref.child("Like").child(id_user).child(self.curentModel.id).setValue(["vactionId" : self.curentModel.id ])
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Datails", comment: "")
        setupView()
        
    }
    
    private func setupView() {
        pagerView.dataSource = self
        
        view.backgroundColor = .systemGray6
        
        
        let sv = UIStackView(arrangedSubviews: [ likeButton])
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        bTitle.translatesAutoresizingMaskIntoConstraints = false
        bDescription.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pagerView)
        
        view.addSubview(bTitle)
        view.addSubview(bDescription)
        view.addSubview(sv)
        view.addSubview(lCommint)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            
            
            pagerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagerView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 3.65),
            pageControl.bottomAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: -10),
            pageControl.trailingAnchor.constraint(equalTo: pagerView.trailingAnchor),
            pageControl.leadingAnchor.constraint(equalTo: pagerView.leadingAnchor),
            sv.heightAnchor.constraint(equalToConstant: 30),
            sv.bottomAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: -45),
            sv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sv.heightAnchor.constraint(equalToConstant: 35),
            sv.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        
        bTitle.topAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: 10).isActive = true
        bTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive  = true
        
        
        bDescription.topAnchor.constraint(equalTo: bTitle.bottomAnchor, constant: 10).isActive = true
        bDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        
        
        
        
        
        lCommint.translatesAutoresizingMaskIntoConstraints                                 = false
        lCommint.topAnchor.constraint(equalTo: bDescription.bottomAnchor, constant: 20).isActive = true
        lCommint.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        lCommint.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        lCommint.heightAnchor.constraint(equalToConstant: 200).isActive                             = true
        
        
        allImage.append( URL.init(string: curentModel.image)!)
        if Language.current.rawValue == "ar" {
            bTitle.text         = curentModel.title_ar
            bDescription.text   = curentModel.desc_ar
        }else{
            bTitle.text         = curentModel.title
            bDescription.text   = curentModel.desc
        }
        
        pageControl.numberOfPages = allImage.count
        
        let ref = Database.database().reference()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let id_user =  user?.uid ?? ""
                
                
                
                ref.child("Places").child(self.curentModel.id).child("Like").child(id_user).observeSingleEvent(of: .value) {snapshot in
                    let value = (snapshot.value as? NSDictionary)
                    if value != nil {
                        
                        self.likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                    }else{
                        self.likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                    }
                }
                
                
                // get comment
                ref.child("Places").child(self.curentModel.id).child("Comment").child(id_user).observeSingleEvent(of: .value) {snapshot in
                    let value = (snapshot.value as? NSDictionary)
                    if value != nil {
                        
                        let text = value?["text"] as? String ?? ""
                        self.lCommint.text = text
                    }
                }
            }
        }
        
        
        // get images
        ref.child("Places").child(curentModel.id).child("images").observeSingleEvent(of: .value) { snapshot in
            let value = (snapshot.value as? NSDictionary)?.allValues
            if value != nil {
                for curentVaction in value!{
                    
                    let value = (curentVaction as? NSDictionary)
                    let image = value?["image"] as? String ?? ""
                    self.allImage.append( URL.init(string: image)!)
                    self.pageControl.numberOfPages = self.allImage.count
                    
                    self.pagerView.reloadData()
                    self.pagerView.reloadInputViews()
                    
                    
                }
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let id_user =  user?.uid ?? ""
                
                // add image like
                let ref = Database.database().reference()
                ref.child("Places").child(self.curentModel.id).child("Comment").child(id_user).setValue(["id" : id_user , "text" : self.lCommint.text ?? ""])
                
                ref.child("Comment").child(id_user).child(self.curentModel.id).setValue(["vactionId" : self.curentModel.id ])
                
                
            }
        }
    }
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return allImage.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: allImage[index], completed: nil)
        cell.textLabel?.text = ""
        return cell
    }
    
}
