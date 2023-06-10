//
//  ProfileViewController.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var cartItem: UIBarButtonItem!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var settingsItem: UIBarButtonItem!
    @IBOutlet weak var loggedInStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if checkLogged() {
            loggedInStack.isHidden = true
            profileView.isHidden = false
            cartItem.isHidden = false
            settingsItem.isHidden = false
        }else{
            loggedInStack.isHidden = false
            cartItem.isHidden = true
            profileView.isHidden = true
            settingsItem.isHidden = true
        }
    }
    
    
    @IBAction func goSignUp(_ sender: Any) {
        
    }
    
    @IBAction func goSignIn(_ sender: Any) {
        
    }
    @IBAction func goSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.settingsStoryboard, bundle: nil)
        let settingsStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.settingsStoryboardID) as! SettingsViewController
        settingsStoryboard.modalPresentationStyle = .fullScreen
        present(settingsStoryboard, animated: true)
    }
    @IBAction func goCart(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.cartStoryboard, bundle: nil)
        let cartStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.cartIdentifier) as! ShoppingCartViewController
        cartStoryboard.modalPresentationStyle = .fullScreen
        present(cartStoryboard, animated: true)
    }
    func checkLogged() -> Bool{
        return true
    }
    
    @IBAction func seeAllOrders(_ sender: Any) {
 
        let ordersStoryBoard = self.storyboard?.instantiateViewController(withIdentifier: Constants.ordersStoryboardID) as! OrdersViewController
       ordersStoryBoard.modalPresentationStyle = .fullScreen
        present(ordersStoryBoard, animated: true)
    }
    
    
    @IBAction func seeAllWishlist(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.favoritesStoryboardName, bundle: nil)
        let favoritesStoryBoard = storyboard.instantiateViewController(withIdentifier: Constants.favoritesStoryboardName) as! FavoritesViewController
        favoritesStoryBoard.modalPresentationStyle = .fullScreen
        present(favoritesStoryBoard, animated: true)
        
    }
}
