//
//  ViewController.swift
//  InDoor-User
//
//  Created by Alaa on 01/06/2023.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func navigate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let recipeDetails = storyboard.instantiateViewController(withIdentifier: "tabbar") as! MainTabBarController
        recipeDetails.modalPresentationStyle = .fullScreen
      
    

        present(recipeDetails, animated: true)
    }
    
}

