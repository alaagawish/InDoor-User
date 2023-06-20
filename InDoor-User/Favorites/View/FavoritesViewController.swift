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
    var favoritesViewModel: FavoritesViewModel!
    var favoritesProducts: [LocalProduct]!
    var defaults: UserDefaults!
    var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesProducts = []
        defaults = UserDefaults.standard
        self.favoritesTable.register(UINib(nibName: Constants.favoritesNibName, bundle: nil), forCellReuseIdentifier: Constants.favoritesCellIdentifier)
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance, network: Network())
        favoritesViewModel.bindResultToViewController = {[weak self] in
            guard let list = self?.favoritesViewModel.result else {return}
            guard let index = self?.index else {return}
            for product in list {
                if(product.id == self?.favoritesProducts[index].id){
                    let storyboard = UIStoryboard(name: Constants.productDetailsStoryboardName, bundle: nil)
                    let productDetails = storyboard.instantiateViewController(withIdentifier: Constants.productDetailsStoryboardName) as! ProductDetailsViewController
                    productDetails.product = product
                    productDetails.modalPresentationStyle = .fullScreen
                    self?.present(productDetails, animated: true)
                    break
                }
            }
        }
        favoritesViewModel.bindallProductsListToController = {[weak self] in
            guard let list = self?.favoritesViewModel.allProductsList else {return}
            for product in list {
                if(product.customer_id == self?.defaults.integer(forKey: Constants.customerId)){
                    self?.favoritesProducts.append(product)
                }
            }
        }
        favoritesViewModel.getAllProducts()
        checkIfThereAreFavoriteProducts(allProductsList: self.favoritesProducts)
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
            let alert = Alert().showRemoveProductFromFavoritesAlert(title: Constants.removeAlertTitle, msg: Constants.removeAlertMessage) {[weak self] action in
                self?.favoritesViewModel.removeProduct(product: (self?.favoritesProducts[indexPath.row])!)
                self?.favoritesProducts.remove(at: indexPath.row)
                self?.favoritesTable.reloadData()
                self?.checkIfThereAreFavoriteProducts(allProductsList: (self?.favoritesProducts)!)
            }
            self.present(alert, animated: true)
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        favoritesViewModel.getRemoteProducts()
    }
}
