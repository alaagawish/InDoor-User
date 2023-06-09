//
//  BrandViewController.swift
//  InDoor-User
//
//  Created by Alaa on 07/06/2023.
//

import UIKit

class BrandViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    var brandViewModel: BrandViewModel!
    var products: [Product] = []
    var id: Int!
    var favoritesViewModel: FavoritesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollectionView.register(UINib(nibName: Constants.brandProductCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.brandProduct)
        
        brandViewModel = BrandViewModel(netWorkingDataSource: Network())
        callingData()
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance)
    }
    func callingData(){
        brandViewModel.bindResultToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.products = self?.brandViewModel.result ?? []
                self?.productsCollectionView.reloadData()
                
            }
        }
        brandViewModel.getItems(id: id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.brandProduct, for: indexPath) as! BrandProductCollectionViewCell
        cell.setValues(product: products[indexPath.row], isFav: favoritesViewModel.checkIfProductIsFavorite(productId: products[indexPath.row].id), viewController: self)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height/4 - 12)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
