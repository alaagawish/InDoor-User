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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoritesTable.register(UINib(nibName: Constants.favoritesNibName, bundle: nil), forCellReuseIdentifier: Constants.favoritesCellIdentifier)
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance)
        favoritesViewModel.getAllProducts()
        checkIfThereAreFavoriteRecipes(allProductsList: self.favoritesViewModel.allProductsList)
    }
    func checkIfThereAreFavoriteRecipes(allProductsList:[LocalProduct]){
        favoritesTable.isHidden = allProductsList.isEmpty
    }
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesViewModel.allProductsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesCellIdentifier) as! FavoritesCell
        cell.setDataToTableCell(product: favoritesViewModel.allProductsList[indexPath.row])
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
                self?.favoritesViewModel.removeProduct(product: (self?.favoritesViewModel.allProductsList[indexPath.row])!)
                self?.favoritesViewModel.allProductsList.remove(at: indexPath.row)
                self?.favoritesTable.reloadData()
                self?.checkIfThereAreFavoriteRecipes(allProductsList: (self?.favoritesViewModel.allProductsList)!)
            }
            self.present(alert, animated: true)
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: Constants.productDetailsStoryboardName, bundle: nil)
        let productDetails = storyboard.instantiateViewController(withIdentifier: Constants.productDetailsStoryboardName) as! ProductDetailsViewController
//        productDetails.product = favoritesViewModel.allProductsList[indexPath.row]
        productDetails.modalPresentationStyle = .fullScreen
        present(productDetails, animated: true)
        
        
    }
}
