//
//  LoginViewController.swift
//  Gigs Project
//
//  Created by Mark Poggi on 4/7/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case signIn
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginTypeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var signInButton: UIButton!
    
    var gigController: GigController?
    var loginType = LoginType.signUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    // MARK: - Action Handlers
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let gigController = gigController else { return }
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty {
            let user = User(username: username, password: password)
            
            if loginType == .signUp {
                gigController.signUp(with: user) { error in
                    if let error = error {
                        print("Error occurred during sign up: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign Up Successful", message: "Now please log in.", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true, completion: {
                                self.loginType = .signIn
                                self.loginTypeSegmentedControl.selectedSegmentIndex = 1
                                self.signInButton.setTitle("Sign In", for: .normal)
                            })
                        }
                    }
                }
            } else {
                gigController.signIn(with: user) { error in
                    if let error = error {
                        print("Error occurred during sign up: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func signInTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            signInButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .signIn
            signInButton.setTitle("Sign In", for: .normal)
        }
    }
}

