//
//  GreatingVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 18/05/1443 AH.
//

import UIKit
import FirebaseAuth

class GreatingVC: UIViewController {
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(#colorLiteral(red: 0.5395174623, green: 0.6461284757, blue: 0.6582974195, alpha: 1))
        view.layer.borderWidth = 0.25
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let greatImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "world")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.text = NSLocalizedString("Welcome", comment: "")
        title.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    let subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.backgroundColor = .clear
        subTitle.text = NSLocalizedString("Best places in world.", comment: "")
        subTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subTitle.textColor = .white
        subTitle.textAlignment = .center
        subTitle.numberOfLines = 0
        return subTitle
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: NSLocalizedString("Sign up", comment: ""))
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: NSLocalizedString("Log in", comment: ""))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(#colorLiteral(red: 0.7731178403, green: 0.7686780691, blue: 0.789144218, alpha: 1))
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isUserSignedIn() {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func setupViews() {
        
        container.translatesAutoresizingMaskIntoConstraints                                                     = false
        
        view.addSubview(container)
        
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                                = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive                                = true
        container.widthAnchor.constraint(equalToConstant: 350).isActive                                         = true
        container.heightAnchor.constraint(equalToConstant: 600).isActive                                        = true
        
        
        
        
        let vStack = UIStackView(arrangedSubviews: [signInButton, loginButton])
        
        vStack.distribution = .fillEqually
        vStack.spacing = 10
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(vStack)
        
        vStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20).isActive = true
        vStack.heightAnchor.constraint(equalToConstant: 40).isActive                                                = true
        vStack.widthAnchor.constraint(equalToConstant: 190).isActive = true
        vStack.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20).isActive = true
        vStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive = true
        
        
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        subTitle.translatesAutoresizingMaskIntoConstraints                                                          = false
        
        container.addSubview(subTitle)
        
        subTitle.bottomAnchor.constraint(equalTo: vStack.topAnchor, constant: -40).isActive                         = true
        subTitle.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive                            = true
        subTitle.widthAnchor.constraint(equalToConstant: 305).isActive                                              = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints                                                        = false
        
        container.addSubview(titleLabel)
        
        titleLabel.bottomAnchor.constraint(equalTo: subTitle.topAnchor, constant:-60).isActive                     = true
        titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive                          = true
        
        
        
        greatImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        container.addSubview(greatImage)
        greatImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -60).isActive             = true
        greatImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive     = true
        greatImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20).isActive  = true
        greatImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 40).isActive             = true
        greatImage.layer.cornerRadius = 40
        
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.pushViewController(LoginScreen(), animated: true)
    }
    @objc private func signInButtonTapped() {
        navigationController?.pushViewController(SignupScreen(), animated: true)
    }
    private func isUserSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
}


