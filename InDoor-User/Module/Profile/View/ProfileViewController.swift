//
//  ProfileViewController.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cartItem: UIBarButtonItem!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var settingsItem: UIBarButtonItem!
    @IBOutlet weak var loggedInStack: UIStackView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var wishlistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderTableView.register(UINib(nibName: Constants.orderNibFile, bundle: nil), forCellReuseIdentifier: Constants.orderCellIdentifier)
        self.wishlistTableView.register(UINib(nibName: Constants.favoritesNibName, bundle: nil), forCellReuseIdentifier: Constants.favoritesCellIdentifier)
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == wishlistTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesCellIdentifier, for: indexPath) as! FavoritesCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.orderCellIdentifier, for: indexPath) as! OrderTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == wishlistTableView {
           return Constants.favoritesCellHeight
        }else {
            return Constants.orderCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == wishlistTableView {
            return true
        }else {
           return false
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
