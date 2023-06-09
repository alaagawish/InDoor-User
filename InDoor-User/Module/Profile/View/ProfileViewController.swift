//
//  ProfileViewController.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var refreshOutLet: UIBarButtonItem!
    @IBOutlet weak var noInternetImage: UIImageView!
    @IBOutlet weak var seeAllOrdersOutlet: UIButton!
    @IBOutlet weak var noOrderImage: UIImageView!
    @IBOutlet weak var cartItem: UIBarButtonItem!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var settingsItem: UIBarButtonItem!
    @IBOutlet weak var loggedInStack: UIStackView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var wishlistTableView: UITableView!
    
    var orders: [Orders] = []
    var products: [LocalProduct] = []
    var profileViewModel: ProfileViewModel!
    var favoritesViewModel: FavoritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewModel = ProfileViewModel(netWorkingDataSource: Network())
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance,network: Network())
        self.orderTableView.register(UINib(nibName: Constants.orderNibFile, bundle: nil), forCellReuseIdentifier: Constants.orderCellIdentifier)
        self.wishlistTableView.register(UINib(nibName: Constants.favoritesNibName, bundle: nil), forCellReuseIdentifier: Constants.favoritesCellIdentifier)
        callingData()
        
    }
    
    
    func callingData(){
        profileViewModel.bindOrdersToViewController = {[weak self] in
            self?.orders = self?.profileViewModel.result?.filter{$0.customer?.id == UserDefault().getCustomerId()} ?? []
            self?.orderTableView.reloadData()
        }
        profileViewModel.getOrders()
        favoritesViewModel.getAllProducts()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if Connectivity.sharedInstance.isConnectedToInternet() == true {
            noInternetImage.isHidden = true
            refreshOutLet.isHidden = true
            settingsItem.isEnabled = true
            cartItem.isEnabled = true
            
        }else {
            noInternetImage.isHidden = false
            refreshOutLet.isHidden = false
            settingsItem.isEnabled = false
            cartItem.isEnabled = false
        }
        noOrderImage.isHidden = true
        if checkLogged() {
            loggedInStack.isHidden = true
            profileView.isHidden = false
            //            cartItem.isHidden = false
            //            settingsItem.isHidden = false
        }else{
            loggedInStack.isHidden = false
            //            cartItem.isHidden = true
            profileView.isHidden = true
            //            settingsItem.isHidden = true
        }
        callingData()
        wishlistTableView.reloadData()
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        if Connectivity.sharedInstance.isConnectedToInternet() == true {
            noInternetImage.isHidden = true
            refreshOutLet.isHidden = true
            cartItem.isEnabled = true
            settingsItem.isEnabled = true
        }else {
            noInternetImage.isHidden = false
            refreshOutLet.isHidden = false
            cartItem.isEnabled = false
            settingsItem.isEnabled = false
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == orderTableView{
            if orders.count > 1 {
                noOrderImage.isHidden = true
                orderTableView.isHidden = false
                seeAllOrdersOutlet.isHidden = false
                return 2
            }else if orders.count == 1 {
                noOrderImage.isHidden = true
                orderTableView.isHidden = false
                seeAllOrdersOutlet.isHidden = false
                return 1
            }else if orders.count == 0 {
                noOrderImage.isHidden = false
                orderTableView.isHidden = true
                seeAllOrdersOutlet.isHidden = true
                
            }
        }else if tableView == wishlistTableView {
            if favoritesViewModel.allProductsList.count > 1 {
                
                return 2
            }else if favoritesViewModel.allProductsList.count == 1 {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == wishlistTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesCellIdentifier, for: indexPath) as! FavoritesCell
            cell.setDataToTableCell(product: favoritesViewModel.allProductsList[indexPath.row])
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.orderCellIdentifier, for: indexPath) as! OrderTableViewCell
            cell.setOrderValues(order: orders[indexPath.row])
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == wishlistTableView {
            if(editingStyle == .delete){
                let alert = Alert().showRemoveProductFromFavoritesAlert(title: Constants.removeAlertTitle, msg: Constants.removeAlertMessage) {[weak self] action in
                    self?.favoritesViewModel.removeProduct(product: (self?.favoritesViewModel.allProductsList[indexPath.row])!)
                    self?.favoritesViewModel.allProductsList.remove(at: indexPath.row)
                    self?.wishlistTableView.reloadData()
                    
                }
                self.present(alert, animated: true)
                
            }
        }
    }
    
    @IBAction func goSignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        let signUpStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.signUpIdentifier) as! SignUpViewController
        signUpStoryboard.modalPresentationStyle = .fullScreen
        present(signUpStoryboard, animated: true)
        
    }
    
    @IBAction func goSignIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        let loginStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.loginIdentifier) as! LoginViewController
        loginStoryboard.modalPresentationStyle = .fullScreen
        present(loginStoryboard, animated: true)
    }
    
    @IBAction func goSettings(_ sender: Any) {
        if checkLogged() {
            
            let storyboard = UIStoryboard(name: Constants.settingsStoryboard, bundle: nil)
            let settingsStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.settingsStoryboardID) as! SettingsViewController
            settingsStoryboard.modalPresentationStyle = .fullScreen
            present(settingsStoryboard, animated: true)
        }else {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.alert, msg: "You must login first", positiveButtonTitle: Constants.ok)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func goCart(_ sender: Any) {
        if checkLogged(){
            let storyboard = UIStoryboard(name: Constants.cartStoryboard, bundle: nil)
            let cartStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.cartIdentifier) as! ShoppingCartViewController
            cartStoryboard.modalPresentationStyle = .fullScreen
            present(cartStoryboard, animated: true)
        }else {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.alert, msg: "You must login first", positiveButtonTitle: Constants.ok)
            self.present(alert, animated: true)
        }
    }
    
    func checkLogged() -> Bool{
        if UserDefault().getCustomerId() == -1 {
            return false
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == orderTableView {
            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: Constants.orderDetails) as! OrderDetailsViewController
            storyboard.modalPresentationStyle = .fullScreen
            storyboard.order = orders[indexPath.row]
            present(storyboard, animated: true)
        }
    }
}
