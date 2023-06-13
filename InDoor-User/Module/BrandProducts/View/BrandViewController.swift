//
//  BrandViewController.swift
//  InDoor-User
//
//  Created by Alaa on 07/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

class BrandViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    var brandViewModel: BrandViewModel!
    var products: [Product] = []
    var orginList: [Product] = []
    var id: Int!
    var filterFlag = false
    var favoritesViewModel: FavoritesViewModel!
    var searchQuery: BehaviorRelay<Product>!
    var disposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollectionView.register(UINib(nibName: Constants.brandProductCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.brandProduct)
        disposeBag = DisposeBag()
        brandViewModel = BrandViewModel(netWorkingDataSource: Network())
        callingData()
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance)
        search()
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        priceSlider.isHidden = true
        filterView.isHidden = true
        if let heightConstraint = filterView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = 0
        }
        
    }
    func setSliderValues(){
        
        priceSlider.maximumValue = Float(orginList.max(by: { Double($0.variants?[0].price ?? "") ?? 0 < Double($1.variants?[0].price ?? "") ?? 0  })?.variants?[0].price ?? "0") ?? 0
        priceSlider.minimumValue =  Float(orginList.min(by: { Double($0.variants?[0].price ?? "") ?? 0 < Double($1.variants?[0].price ?? "") ?? 0  })?.variants?[0].price ?? "0") ?? 0
    }
    func search() {
        searchBar.rx.text.subscribe{[weak self] text in
            guard let self = self else {return}
            self.filter(searchText: text!)
        }.disposed(by: disposeBag)
        
    }
    func filter(searchText:String) {
        if(!searchText.isEmpty){
            products = orginList.filter{(Splitter().splitName(text: $0.title!, delimiter: "| ").lowercased().contains(searchText.lowercased()))}
            if products.isEmpty{
                products = []
            }
        }else {
            products = orginList
        }
        self.productsCollectionView.reloadData()
    }
    func callingData() {
        brandViewModel.bindResultToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.products = self?.brandViewModel.result ?? []
                self?.orginList = self?.brandViewModel.result ?? []
                self?.setSliderValues()
                self?.productsCollectionView.reloadData()
                self?.searchQuery = BehaviorRelay<Product>(value: (self?.products[0])!)
            }
        }
        brandViewModel.getItems(id: id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.brandProduct, for: indexPath) as! BrandProductCollectionViewCell
        cell.setValues(product: products[indexPath.row], isFav: favoritesViewModel.checkIfProductIsFavorite(productId: products[indexPath.row].id), viewController: self, view: Constants.brand)
        
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
    
    @IBAction func startFilter(_ sender: Any) {
        
        if filterFlag {
            priceSlider.isHidden = true
            filterView.isHidden = true
            if let heightConstraint = filterView.constraints.first(where: { $0.firstAttribute == .height }) {
                heightConstraint.constant = 0
            }
            
        }else {
            priceSlider.isHidden = false
            filterView.isHidden = false
            if let heightConstraint = filterView.constraints.first(where: { $0.firstAttribute == .height }) {
                heightConstraint.constant = UIScreen.main.bounds.height * 0.03
            }
        }
        filterFlag = !filterFlag
    }
    func filter(){
        products = orginList.filter{Float($0.variants?[0].price ?? "") ?? 0 <= priceSlider.value}
        productsCollectionView.reloadData()
    }
    
    
    @IBAction func filterChanging(_ sender: Any) {
        currentPrice.text = "price: \(Int(priceSlider.value))"
        
        filter()
    }
    
}
