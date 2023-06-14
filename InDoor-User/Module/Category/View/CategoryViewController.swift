//
//  CategoryViewController.swift
//  InDoor-User
//
//  Created by Alaa on 09/06/2023.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var saleBarItem: UIBarButtonItem!
    @IBOutlet weak var accBarItem: UIBarButtonItem!
    @IBOutlet weak var shoesBarItem: UIBarButtonItem!
    @IBOutlet weak var shirtBarItem: UIBarButtonItem!
    @IBOutlet weak var kidsBarItem: UIBarButtonItem!
    @IBOutlet weak var menBarItem: UIBarButtonItem!
    @IBOutlet weak var allproducts: UIBarButtonItem!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var subCategoriesToolbar: UIToolbar!
    @IBOutlet weak var womenBarItem: UIBarButtonItem!
    @IBOutlet weak var categoriesToolbar: UIToolbar!
    
    var products: [Product] = []
    var currentProducts: [Product] = [] {
        didSet{
            if Array(Set(currentProducts)).count == products.count  && currentProducts.count != 0 {
                products = currentProducts
                disableToolbarItems(status: false)
                productsCollectionView.reloadData()
                
            }
        }
    }
    var favoritesViewModel: FavoritesViewModel!
    var categoryViewModel: CategoryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryViewModel = CategoryViewModel(netWorkingDataSource: Network())
        productsCollectionView.register(UINib(nibName: Constants.brandProductCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.brandProduct)
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance)
        
        callingData()
        
    }
    func callingData(){
        categoryViewModel.bindResultToViewController = {[weak self] in
            self?.products = self?.categoryViewModel.result ?? []
            self?.currentProducts = []
            for product in 0 ..< (self?.products.count ?? 0)  {
                
                self?.categoryViewModel.getPrice(i: (self?.products[product])! , completionHandler: {  product in
                    self?.currentProducts.append(product)
                })
            }
        }
        
        categoryViewModel.getItems(id: Constants.womenID)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        womenProducts(womenBarItem!)
        allProducts(allproducts!)
        disableToolbarItems(status: true)
    }
    
    func tintCurrentItem(_ sender: Any,_ id: Int) {
        if id == 0{
            for item in categoriesToolbar.items ?? [] {
                item.tintColor = UIColor.gray
            }
        }else{
            for item in subCategoriesToolbar.items ?? [] {
                item.tintColor = UIColor.gray
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products = Array(Set(products))
        return Array(Set(products)).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.brandProduct, for: indexPath) as! BrandProductCollectionViewCell
        
        cell.setValues(product: products[indexPath.row], isFav: favoritesViewModel.checkIfProductIsFavorite(productId: products[indexPath.row].id), viewController: self, view: Constants.category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.productDetailsStoryboardName, bundle: nil)
        let productDetails = storyboard.instantiateViewController(withIdentifier: Constants.productDetailsStoryboardName) as! ProductDetailsViewController
        productDetails.product = products[indexPath.row]
        productDetails.modalPresentationStyle = .fullScreen
        present(productDetails, animated: true)
    }
    
    @IBAction func womenProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        products = []
        currentProducts = []
        categoryViewModel.getItems(id: Constants.womenID)
        disableToolbarItems(status: true)
        allProducts(allproducts!)
    }
    
    @IBAction func menProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        products = []
        disableToolbarItems(status: true)
        currentProducts = []
        categoryViewModel.getItems(id: Constants.menID)
        allProducts(allproducts!)
    }
    
    @IBAction func kidsProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        products = []
        disableToolbarItems(status: true)
        currentProducts = []
        categoryViewModel.getItems(id: Constants.kidID)
        allProducts(allproducts!)
    }
    @IBAction func saleProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        products = []
        currentProducts = []
        disableToolbarItems(status: true)
        categoryViewModel.getItems(id: Constants.saleID)
        
        allProducts(allproducts!)
    }
    
    @IBAction func allProducts(_ sender: Any) {
        tintCurrentItem(sender,1)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        products = currentProducts
        productsCollectionView.reloadData()
        
    }
    
    @IBAction func shoesProducts(_ sender: Any) {
        tintCurrentItem(sender,1)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        
        products = currentProducts.filter{$0.productType == Constants.shoes}
        productsCollectionView.reloadData()
    }
    
    @IBAction func shirtProducts(_ sender: Any) {
        tintCurrentItem(sender,1)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        products = currentProducts.filter{$0.productType == Constants.tShirt}
        
        productsCollectionView.reloadData()
    }
    
    @IBAction func accessoriesProducts(_ sender: Any) {
        tintCurrentItem(sender,1)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        products = currentProducts.filter{$0.productType == Constants.accessories}
        productsCollectionView.reloadData()
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
        return UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    }

    @IBAction func moveToFavourites(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.favoritesStoryboardName, bundle: nil)
        let favoritesStoryBoard = storyboard.instantiateViewController(withIdentifier: Constants.favoritesStoryboardName) as! FavoritesViewController
        favoritesStoryBoard.modalPresentationStyle = .fullScreen
        present(favoritesStoryBoard, animated: true)
    }
    @IBAction func moveToShoppingCart(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.cartStoryboard, bundle: nil)
        let cartStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.cartIdentifier) as! ShoppingCartViewController
        cartStoryboard.modalPresentationStyle = .fullScreen
        present(cartStoryboard, animated: true)
        
    }
    func disableToolbarItems(status: Bool) {
        
        if status {
            
            womenBarItem.isEnabled = false
            allproducts.isEnabled = false
            menBarItem.isEnabled = false
            kidsBarItem.isEnabled = false
            accBarItem.isEnabled = false
            saleBarItem.isEnabled = false
            shoesBarItem.isEnabled = false
            shirtBarItem.isEnabled = false
            
        }else {
            womenBarItem.isEnabled = true
            allproducts.isEnabled = true
            menBarItem.isEnabled = true
            kidsBarItem.isEnabled = true
            accBarItem.isEnabled = true
            saleBarItem.isEnabled = true
            shoesBarItem.isEnabled = true
            shirtBarItem.isEnabled = true
            
        }
    }
}
