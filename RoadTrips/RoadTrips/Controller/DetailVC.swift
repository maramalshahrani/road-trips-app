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
import Cosmos
import IQKeyboardManagerSwift
class DetailVC: UIViewController , FSPagerViewDataSource, CWRateKitViewControllerDelegate {
    func didChange(rate: Int) {
        print(rate)
    }
    
    func didDismiss() {
        print("didDismiss")

    }
    
    func didSubmit(rate: Int) {
        print("didSubmit")
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let id_user =  user?.uid ?? ""
        let ref = Database.database().reference()
        ref.child("Places").child(self.curentModel.id).child("Rates").child(id_user).setValue(["id" : id_user])
                ref.child("Places").child(self.curentModel.id).child("rateCount").observeSingleEvent(of: .value) { snap in
                    let oldCount = Int(snap.value as! String) ?? 0
                    let newCount = oldCount + 1
                    
                    
                    ref.child("Places").child(self.curentModel.id).updateChildValues(["rateCount": "\(newCount)"])
                    ref.child("Places").child(self.curentModel.id).child("rate").observeSingleEvent(of: .value) { snap in
                        let oldRate = Double(snap.value as! String) ?? 0.0
                        
                        
                        let newRate = ((Double(oldCount) * oldRate) + Double(rate)) /  Double(newCount)
                        ref.child("Places").child(self.curentModel.id).updateChildValues(["rate": "\(newRate)"])
                        self.rateButton.isHidden = true
                    }

                }
                ref.child("Rate").child(id_user).child(self.curentModel.id).setValue(["vactionId" : self.curentModel.id , "rate" : "\(rate)"])
            }
        }

    }
    
    var curentModel : Vaction!
    
    var allImage = [URL]()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private let rateView: CosmosView = {
        let rateView = CosmosView()
        rateView.settings.totalStars = 5
        rateView.isUserInteractionEnabled = false
        
        return rateView
    }()
    let pagerView: FSPagerView =  {
        let pagerView = FSPagerView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
        
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.automaticSlidingInterval = 1.5
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
    
    private let covedTitle: UILabel = {
        let title = UILabel()
        title.textColor     =  UIColor(#colorLiteral(red: 0.3226320446, green: 0.236202091, blue: 0.2579532862, alpha: 1))
        title.font          = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 25, weight: .bold))
        title.text = "Total confirmed cases".localized
        return title
    }()
    private let covedValue: UILabel = {
        let covedValue             = UILabel()
        covedValue.textColor       =  UIColor(#colorLiteral(red: 0.4026142359, green: 0.2947920859, blue: 0.3219620883, alpha: 1))
        covedValue.font            = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .bold))
        
        return covedValue
    }()
    
    private let lCommint: IQTextView = {
        let description             = IQTextView()
        description.backgroundColor = UIColor.init(named: "WhiteColor")!
        description.textColor       =  UIColor(#colorLiteral(red: 0.4026142359, green: 0.2947920859, blue: 0.3219620883, alpha: 1))
        description.font            = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        description.placeholder = "Write comment here".localized
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
    let rateButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("add Rate".localized, for: .normal)
        button.setTitleColor( UIColor(red: 1, green: 149/255, blue: 0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(rateButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func rateButtonAction() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
            
                let rateViewController = CWRateKitViewController()
                       rateViewController.modalPresentationStyle = .overFullScreen
                rateViewController.delegate = self
                
                self.present(rateViewController, animated: true, completion: nil)
                
                
            }
        }
    }
        
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
            lCommint.delegate = self

        }
    func setupScrollView(){
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           contentView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(scrollView)
           scrollView.addSubview(contentView)
           
           scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
           scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           
           contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
           contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
           contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
           contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
       }
    
        private func setupView() {
            setupScrollView()
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
            rateView.translatesAutoresizingMaskIntoConstraints = false
            covedTitle.translatesAutoresizingMaskIntoConstraints = false
            covedValue.translatesAutoresizingMaskIntoConstraints = false
            rateView.translatesAutoresizingMaskIntoConstraints = false
            rateButton.translatesAutoresizingMaskIntoConstraints = false

            contentView.addSubview(pagerView)
            contentView.addSubview(rateView)
            contentView.addSubview(rateButton)

            contentView.addSubview(bTitle)
            contentView.addSubview(bDescription)
            contentView.addSubview(sv)
            contentView.addSubview(lCommint)
            contentView.addSubview(pageControl)
            contentView.addSubview(covedTitle)
            contentView.addSubview(covedValue)
            
            NSLayoutConstraint.activate([
                
                
                pagerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
                pagerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                pagerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                pagerView.heightAnchor.constraint(equalToConstant: 300),
                pageControl.bottomAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: -10),
                pageControl.trailingAnchor.constraint(equalTo: pagerView.trailingAnchor),
                pageControl.leadingAnchor.constraint(equalTo: pagerView.leadingAnchor),
                sv.heightAnchor.constraint(equalToConstant: 30),
                sv.bottomAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: -45),
                sv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                sv.heightAnchor.constraint(equalToConstant: 35),
                sv.widthAnchor.constraint(equalToConstant: 35),
                
                sv.widthAnchor.constraint(equalToConstant: 200),
                sv.heightAnchor.constraint(equalToConstant: 30)
                
            ])
            
            bTitle.topAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: 10).isActive = true
            bTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            bTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive  = true
            
            
            rateView.topAnchor.constraint(equalTo: bTitle.bottomAnchor, constant: 10).isActive = true
            rateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            
            rateButton.topAnchor.constraint(equalTo: bTitle.bottomAnchor, constant: 3).isActive = true
            rateButton.leadingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: 20).isActive = true
            
            
            
            covedTitle.topAnchor.constraint(equalTo: rateView.bottomAnchor, constant: 20).isActive = true
            covedTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            covedTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive  = true
            
            
            
            covedValue.topAnchor.constraint(equalTo: covedTitle.bottomAnchor, constant: 10).isActive = true
            covedValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            covedValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive  = true
            
            
            
            
            bDescription.topAnchor.constraint(equalTo: covedValue.bottomAnchor, constant: 10).isActive = true
            bDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            bDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            
            
            
            
            
            
            
            lCommint.translatesAutoresizingMaskIntoConstraints                                 = false
            lCommint.topAnchor.constraint(equalTo: bDescription.bottomAnchor, constant: 20).isActive = true
            lCommint.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
            lCommint.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
            lCommint.heightAnchor.constraint(equalToConstant: 160).isActive                             = true
            lCommint.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
            
            allImage.append( URL.init(string: curentModel.image)!)
            rateView.rating = Double(curentModel.rate) ?? 0.0
            rateView.text =  "( " + curentModel.rateCount + " )"
            covedValue.text = curentModel.activeCovid
            
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
                    
                    ref.child("Places").child(self.curentModel.id).child("Rates").child(id_user).observeSingleEvent(of: .value) {snapshot in
                        let value = (snapshot.value as? NSDictionary)
                        if value != nil {
                            
                            self.rateButton.isHidden = true
                        }else{
                            self.rateButton.isHidden = false
                        }
                    }
                    
                    
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

extension DetailVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }
}
