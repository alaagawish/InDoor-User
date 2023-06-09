//
//  CategoryViewController.swift
//  InDoor-User
//
//  Created by Alaa on 09/06/2023.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var allproducts: UIBarButtonItem!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var subCategoriesToolbar: UIToolbar!
    @IBOutlet weak var womenBarItem: UIBarButtonItem!
    @IBOutlet weak var categoriesToolbar: UIToolbar!
    
    var products: [Product] = []
    var currentProducts: [Product] = []
    var categoryViewModel: CategoryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        categoryViewModel = CategoryViewModel(netWorkingDataSource: Network())
        productsCollectionView.register(UINib(nibName: Constants.brandProductCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.brandProduct)
        callingData()
        
    }
    func callingData(){
        categoryViewModel.bindResultToViewController = {[weak self] in
            DispatchQueue.main.async {
                
                self?.products = self?.categoryViewModel.result ?? []
                self?.currentProducts = self?.categoryViewModel.result ?? []
                print(self?.currentProducts)
                self?.productsCollectionView.reloadData()
                
            }
        }
        categoryViewModel.getItems(id: Constants.womenID)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        womenProducts(womenBarItem)
        allProducts(allproducts)
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
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.brandProduct, for: indexPath) as! BrandProductCollectionViewCell
        cell.setValuess(image: products[indexPath.row].image?.src ?? "" , title: products[indexPath.row].title ?? "", isFav: true, viewController: self)
        return cell
    }
    
    @IBAction func womenProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        categoryViewModel.getItems(id: Constants.womenID)
        allProducts(allproducts)
    }
    
    @IBAction func menProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        categoryViewModel.getItems(id: Constants.menID)
        allProducts(allproducts)
    }
    
    @IBAction func kidsProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        categoryViewModel.getItems(id: Constants.kidID)
        allProducts(allproducts)
    }
    @IBAction func saleProducts(_ sender: Any) {
        tintCurrentItem(sender,0)
        (sender as! UIBarButtonItem).tintColor = UIColor.black
        categoryViewModel.getItems(id: Constants.saleID)
        allProducts(allproducts)
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
        print(currentProducts[0].productType)
        products = currentProducts.filter{$0.productType == Constants.shoes}
        print(products)
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
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
