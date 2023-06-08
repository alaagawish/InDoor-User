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
        self.favoritesTable.register(UINib(nibName: Constants.nibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance)
        favoritesViewModel.addProduct(product: LocalProduct(id: 1, title: "Active Shoes", status: "Available", price: "$50.0", image: "https://contents.mediadecathlon.com/p1268526/k$4546c5593e363bc0081730fa7e1d8a2d/women-s-nh150-mid-wp-waterproof-off-road-hiking-shoes.jpg?format=auto&quality=40&f=250x250"))
        favoritesViewModel.getAllProducts()
        checkIfThereAreFavoriteRecipes(allProductsList: self.favoritesViewModel.allProductsList)
    }
    func checkIfThereAreFavoriteRecipes(allProductsList:[LocalProduct]){
        favoritesTable.isHidden = allProductsList.isEmpty
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesViewModel.allProductsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! FavoritesCell
        cell.setDataToTableCell(product: favoritesViewModel.allProductsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let alert = UIAlertController(title: "Warning!!", message: "Are You sure you want to delete this product?", preferredStyle: UIAlertController.Style.actionSheet)
            let action1 = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default){_ in
                self.favoritesViewModel.removeProduct(product: self.favoritesViewModel.allProductsList[indexPath.row])
                self.favoritesViewModel.allProductsList.remove(at: indexPath.row)
                self.favoritesTable.reloadData()
                self.checkIfThereAreFavoriteRecipes(allProductsList: self.favoritesViewModel.allProductsList)
            }
            let action2 = UIAlertAction(title: "No", style: UIAlertAction.Style.default)
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true)
           
        }
    }
}
extension FavoritesViewController{
    class Constants {
        static let nibName = "FavoritesCell"
        static let cellIdentifier = "favoriteCell"
        static let cellHeight = 145.0
        static let titleOfDeleteButton = "Delete"
    }
}
