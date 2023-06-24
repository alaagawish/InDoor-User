//
//  FavoritesViewController.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit
import Kingfisher

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesTable: UITableView!
    var favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance, network: Network())
    var favoritesProducts: [LocalProduct] = []
    var defaults: UserDefaults = UserDefaults.standard
    var index: Int = 0
    static var staticFavoriteList: [LocalProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNibForCell()
        getProductsFromDataBase()
        matchFavouriteProductsToAPIProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesProducts = []
        favoritesViewModel.getAllProducts()
        checkIfThereAreFavoriteProducts(allProductsList: self.favoritesProducts)
        favoritesTable.reloadData()
    }
    
    func setUpNibForCell(){
        self.favoritesTable.register(UINib(nibName: Constants.favoritesNibName, bundle: nil), forCellReuseIdentifier: Constants.favoritesCellIdentifier)
    }
    
    func getProductsFromDataBase(){
        favoritesViewModel.bindallProductsListToController = {[weak self] in
            guard let list = self?.favoritesViewModel.allProductsList else {return}
            for product in list {
                if(product.customer_id == self?.defaults.integer(forKey: Constants.customerId)){
                    self?.favoritesProducts.append(product)
                }
            }
        }
    }
    
    func matchFavouriteProductsToAPIProducts(){
        favoritesViewModel.bindResultToViewController = {[weak self] in
            guard let list = self?.favoritesViewModel.result else {return}
            guard let index = self?.index else {return}
            for product in list {
                if(product.id == self?.favoritesProducts[index].id ?? 0){
                    let storyboard = UIStoryboard(name: Constants.productDetailsStoryboardName, bundle: nil)
                    let productDetails = storyboard.instantiateViewController(withIdentifier: Constants.productDetailsStoryboardName) as! ProductDetailsViewController
                    productDetails.product = product
                    productDetails.modalPresentationStyle = .fullScreen
                    self?.present(productDetails, animated: true)
                    break
                }
            }
        }
    }
    
    func checkIfThereAreFavoriteProducts(allProductsList:[LocalProduct]){
        favoritesTable.isHidden = allProductsList.isEmpty
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesCellIdentifier) as! FavoritesCell
        cell.setDataToTableCell(product: favoritesProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.favoritesCellHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            showDeleteAlert(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        favoritesViewModel.getRemoteProducts()
    }
    
    func showDeleteAlert(index: Int){
        let alert = Alert().showRemoveProductFromFavoritesAlert(title: Constants.removeAlertTitle, msg: Constants.removeAlertMessage) {[weak self] action in
            self?.favoritesViewModel.removeProduct(product: (self?.favoritesProducts[index])!)
            self?.favoritesProducts.remove(at: index)
            self?.favoritesTable.reloadData()
            self?.favoritesViewModel.getAllProducts()
            self?.checkIfThereAreFavoriteProducts(allProductsList: (self?.favoritesProducts)!)
        }
        self.present(alert, animated: true)
    }
}
