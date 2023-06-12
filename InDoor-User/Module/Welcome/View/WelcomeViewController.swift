//
//  WelcomeViewController.swift
//  InDoor-User
//
//  Created by Mac on 11/06/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func navigateToHomeAsGuest(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
        let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
        defaults.setValue(-1, forKey: Constants.customerId)
        home.modalPresentationStyle = .fullScreen
        present(home, animated: true)

    }
    
    @IBAction func NavigateToLogin(_ sender: UIButton) {
        let login = storyboard?.instantiateViewController(identifier: Constants.loginIdentifier) as! LoginViewController
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true)
    }
    
    @IBAction func navigateToSignUp(_ sender: UIButton) {
        let signup = storyboard?.instantiateViewController(identifier: Constants.signUpIdentifier) as! SignUpViewController
        signup.modalPresentationStyle = .fullScreen
        present(signup, animated: true)
    }
}
