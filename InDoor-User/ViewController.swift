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

    @IBAction func navigateToFav(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "FavoritesStoryBoard", bundle: nil)
                let FavoritesStoryBoard = storyboard.instantiateViewController(withIdentifier: "FavoritesStoryBoard") as! FavoritesViewController
        FavoritesStoryBoard.modalPresentationStyle = .fullScreen
                present(FavoritesStoryBoard, animated: true)
    }
    
}

