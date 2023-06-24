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
        let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
        let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
        home.modalPresentationStyle = .fullScreen
        present(home, animated: true)
    }
//    @IBAction func navigateToFav(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "FavoritesStoryBoard", bundle: nil)
//                let FavoritesStoryBoard = storyboard.instantiateViewController(withIdentifier: "FavoritesStoryBoard") as! FavoritesViewController
//        FavoritesStoryBoard.modalPresentationStyle = .fullScreen
//                present(FavoritesStoryBoard, animated: true)
//    }
    
}

