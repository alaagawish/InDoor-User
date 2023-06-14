//
//  launchScreenViewController.swift
//  InDoor-User
//
//  Created by Mac on 14/06/2023.
//

import UIKit
import Lottie
class launchScreenViewController: UIViewController {
    
    @IBOutlet weak var animatedView: LottieAnimationView!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        animatedView.contentMode = .scaleAspectFit
        animatedView.loopMode = .playOnce
        animatedView.animationSpeed = 1
        animatedView.play(){[weak self] _ in
            if(self?.defaults.integer(forKey: Constants.customerId) == -1){
                let welcome = self?.storyboard?.instantiateViewController(identifier: Constants.welcomeIdentifier) as! WelcomeViewController
                welcome.modalPresentationStyle = .fullScreen
                self?.present(welcome, animated: true)
            }
            else{
                let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                home.modalPresentationStyle = .fullScreen
                self?.present(home, animated: true)
            }
        }
    }
    
}
