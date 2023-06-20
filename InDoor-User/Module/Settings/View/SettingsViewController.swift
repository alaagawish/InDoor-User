//
//  SettingsViewController.swift
//  InDoor-User
//
//  Created by Mac on 03/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var connectToUsView: UIView!
    @IBOutlet weak var aboutInDoorView: UIView!
    
    var favoritesViewModel: FavoritesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance, network: Network())
        var lineItems:[LineItems] = []
        favoritesViewModel.bindPutfavoriteDraftOrderToController = {[weak self] in
            let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.warning, msg: Constants.logoutMessage, negativeButtonTitle: Constants.cancel, positiveButtonTitle: Constants.ok) {[weak self] _ in
                UserDefault().logout()
                if(UserDefaults.standard.bool(forKey: Constants.isGoogle) == true){
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                }
                let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
                let welcome = storyboard.instantiateViewController(identifier: Constants.welcomeIdentifier) as! WelcomeViewController
                welcome.modalPresentationStyle = .fullScreen
                self?.present(welcome, animated: true)
            }
            self?.present(alert, animated: true)
        }
        favoritesViewModel.bindallProductsListToController = {[weak self] in
            guard let list = self?.favoritesViewModel.allProductsList else {return}
            for product in list {
                lineItems.append(LineItems(productId: product.id , price: product.price, quantity: 1 , title: product.title, properties: [Properties(name: "image_url", value: product.image )]))
            }
            let draftOrder = DraftOrder(id: nil, note: nil, lineItems: lineItems, user: nil)
            
            let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: nil, draftOrder: draftOrder, orders: nil,order: nil)
            
            let params = JSONCoding().encodeToJson(objectClass: response)!
           
            print("params: \(params)")
            self?.favoritesViewModel.putFavoriteDraftOrderFromAPI(parameters: params )
        }
        setupUI()
        setupTapGesture()
    }
    
    func setupUI(){
        logoutButton.layer.cornerRadius = 12
        setupUIView(uiView: addressView)
        setupUIView(uiView: currencyView)
        setupUIView(uiView: connectToUsView)
        setupUIView(uiView: aboutInDoorView)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 20
        uiView.layer.shadowColor = UIColor.gray.cgColor
        uiView.layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        uiView.layer.shadowRadius = 8.0
        uiView.layer.shadowOpacity = 0.5
        uiView.layer.masksToBounds = false
    }
    
    func setupTapGesture(){
        let addressTap = UITapGestureRecognizer(target: self, action: #selector(self.addressTap(_:)))
        addressView.addGestureRecognizer(addressTap)
        
        let currencyTap = UITapGestureRecognizer(target: self, action: #selector(self.currencyTap(_:)))
        currencyView.addGestureRecognizer(currencyTap)
        
        let connectToUsTap = UITapGestureRecognizer(target: self, action: #selector(self.connectToUsTap(_:)))
        connectToUsView.addGestureRecognizer(connectToUsTap)
        
        let aboutInDoorTap = UITapGestureRecognizer(target: self, action: #selector(self.aboutInDoorTap(_:)))
        aboutInDoorView.addGestureRecognizer(aboutInDoorTap)
    }
    
    @objc func addressTap(_ sender: UITapGestureRecognizer? = nil) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: Constants.addressIdentifier) as! AddressViewController
        address.modalPresentationStyle = .fullScreen
        present(address, animated: true)
    }
    
    @objc func currencyTap(_ sender: UITapGestureRecognizer? = nil) {
        let currency = self.storyboard?.instantiateViewController(withIdentifier: Constants.currencyIdentifier) as! CurrencyViewController
        currency.modalPresentationStyle = .fullScreen
        present(currency, animated: true)
    }
    
    @objc func connectToUsTap(_ sender: UITapGestureRecognizer? = nil) {
        let connect = self.storyboard?.instantiateViewController(withIdentifier: Constants.connectToUsIdentifier) as! ConnectToUsViewController
        connect.modalPresentationStyle = .fullScreen
        present(connect, animated: true)
    }
    
    @objc func aboutInDoorTap(_ sender: UITapGestureRecognizer? = nil) {
        let about = self.storyboard?.instantiateViewController(withIdentifier: Constants.aboutInDoorIdentifier) as! AboutInDoorViewController
        about.modalPresentationStyle = .fullScreen
        present(about, animated: true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func logout(_ sender: Any) {
        self.postFavoritesDraftOrderFromLocalToRemote()
        
    }
    func postFavoritesDraftOrderFromLocalToRemote(){
        self.favoritesViewModel.getAllProducts()
    }
}

