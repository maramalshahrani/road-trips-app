//
//  LoginScreen.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 19/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginScreen: UIViewController {
    
    let db = Firestore.firestore()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(#colorLiteral(red: 0.5748942494, green: 0.6918305159, blue: 0.6890054345, alpha: 1))
        view.layer.borderWidth = 0.25
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let showImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pass")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.text = NSLocalizedString("Welcome back", comment: "")
        title.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.setupTF(with: NSAttributedString(string:NSLocalizedString("Email", comment: ""),
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]))
        return textField
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.setupTF(with: NSAttributedString(string: NSLocalizedString("Password", comment: ""),
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]))
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: NSLocalizedString("Login", comment: ""))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupViews()
    }
    
    private func setupViews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                                = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive                                = true
        containerView.widthAnchor.constraint(equalToConstant: 350).isActive                                         = true
        containerView.heightAnchor.constraint(equalToConstant: 600).isActive                                        = true
        
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        createAccountButton.addTarget(self, action: #selector(loginUserTapped), for: .touchUpInside)
        
        containerView.addSubview(createAccountButton)
        
        createAccountButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        createAccountButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        createAccountButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        createAccountButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        containerView.addSubview(passwordTextField)
        
        passwordTextField.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -15).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.delegate = self
        containerView.addSubview(emailTextField)
        
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -5).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
        
        titleLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        
        
        showImage.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(showImage)
        showImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -60).isActive             = true
        showImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive     = true
        showImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive  = true
        showImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive             = true
        showImage.layer.cornerRadius = 40
        
    }
    
    @objc private func loginUserTapped() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if !email.isEmpty && !password.isEmpty {
            loginUsing(email: email, password: password)
        }else{
            let alert = UIAlertController(title:NSLocalizedString("Oops!", comment: "") , message:NSLocalizedString("please make sure email and password are not empty.", comment: "") , preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:NSLocalizedString("OK", comment: "") , style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
        
    }
    private func loginUsing(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    
                    let alert = UIAlertController(title:NSLocalizedString("Oops!", comment: ""), message: NSLocalizedString("you entered a wrong password", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                case .invalidEmail:
                    
                    let alert = UIAlertController(title: NSLocalizedString("Oops!", comment: ""), message: NSLocalizedString("are sure you typed the email correctly?", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                case .weakPassword:
                    
                    let alert = UIAlertController(title: NSLocalizedString("Oops!", comment: ""), message: NSLocalizedString("Your password is weak, please make sure it's strong.", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                default:
                    
                    let alert = UIAlertController(title: NSLocalizedString("Oops!", comment: ""), message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                }
            }else{
                // Ma feh ay error fra7 nd5l al user llt6be8...
                guard let user = results?.user else {return}
                
                self.db.collection("users").document(user.uid).setData([
                    "emai": String(user.email!),
                    "userID": user.uid,
                    "status": "yes"
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
                let vc = TabBarVC()
                let nav = UINavigationController()
                nav.viewControllers = [vc]
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .flipHorizontal
                self.present(nav, animated: true, completion: nil)
                
                
                
                //                self.navigationController?.popToRootViewController(animated: true)
                //                self.navigationController?.pushViewController(TabBarVC(), animated: true)
            }
            
            
        }
    }
    
}



extension LoginScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
}
