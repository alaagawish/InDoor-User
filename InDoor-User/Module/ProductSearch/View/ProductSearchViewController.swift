//
//  ProductSearchViewController.swift
//  InDoor-User
//
//  Created by Mac on 16/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ProductSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var bestSellerFloatingButton: UIButton!
    @IBOutlet weak var priceFloatingButton: UIButton!
    @IBOutlet weak var inputSearchBar: UISearchBar!
    
    @IBOutlet weak var alphabetFloatingButton: UIButton!
    @IBOutlet weak var sortingButton: UIButton!
    
    @IBOutlet weak var searchTableView: UITableView!
    var disposeBag: DisposeBag!
    var sortingTypesFlag = false
    var productSearchViewModel: ProductSearchViewModel!
    var products: [Product] = []
    var productList: [Product] = []
    var defaults: UserDefaults!
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = UserDefaults.standard
        self.searchTableView.register(UINib(nibName: Constants.favoritesNibName, bundle: nil), forCellReuseIdentifier: Constants.favoritesCellIdentifier)
        disposeBag = DisposeBag()
        if defaults.string(forKey: Constants.comingToSearchFrom) == Constants.comingToSearchFromHome{
            productSearchViewModel = ProductSearchViewModel(networkManager: Network())
            productSearchViewModel.bindResultToViewController = { [weak self] in
                self?.search()
            }
            productSearchViewModel.getItems()
        } else {
            productList = products
            search()
        }
        setUpUI()
    }
    func setUpUI(){
        if !sortingTypesFlag{
            alphabetFloatingButton.isHidden = true
            priceFloatingButton.isHidden = true
            bestSellerFloatingButton.isHidden = true
        }
        sortingButton.layer.shadowRadius = 10
        sortingButton.layer.shadowOpacity = 0.3
        sortingButton.layer.cornerRadius = 30
        
        alphabetFloatingButton.layer.shadowRadius = 10
        alphabetFloatingButton.layer.shadowOpacity = 0.3
        alphabetFloatingButton.layer.cornerRadius = 30
        
        bestSellerFloatingButton.layer.shadowRadius = 10
        bestSellerFloatingButton.layer.shadowOpacity = 0.3
        bestSellerFloatingButton.layer.cornerRadius = 30
        
        priceFloatingButton.layer.shadowRadius = 10
        priceFloatingButton.layer.shadowOpacity = 0.3
        priceFloatingButton.layer.cornerRadius = 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesCellIdentifier) as! FavoritesCell
        cell.setProductToTableCell(product: products[indexPath.row])
        return cell
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func search() {
        inputSearchBar.rx.text.subscribe{[weak self] text in
            guard let self = self else {return}
            self.filter(searchText: text!)
        }.disposed(by: disposeBag)
    }
    
    
    func filter(searchText:String) {
        if defaults.string(forKey: Constants.comingToSearchFrom) == Constants.comingToSearchFromHome{
            if(!searchText.isEmpty){
                products = productSearchViewModel.result.filter{(Splitter().splitName(text: $0.title!, delimiter: "| ").lowercased().contains(searchText.lowercased()))}
                if products.isEmpty{
                    products = []
                }
            }else {
                products = productSearchViewModel.result
            }
            self.searchTableView.reloadData()
        }
        else{
            if(!searchText.isEmpty){
                products = productList.filter{(Splitter().splitName(text: $0.title!, delimiter: "| ").lowercased().contains(searchText.lowercased()))}
                if products.isEmpty{
                    products = []
                }
            } else {
                products = productList
            }
            self.searchTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.favoritesCellHeight
    }
    
    @IBAction func filter(_ sender: Any) {
        sortingTypesFlag = !sortingTypesFlag
        if sortingTypesFlag {
            alphabetFloatingButton.isHidden = false
            priceFloatingButton.isHidden = false
            bestSellerFloatingButton.isHidden = false
        }else {
            alphabetFloatingButton.isHidden = true
            priceFloatingButton.isHidden = true
            bestSellerFloatingButton.isHidden = true
        }
    }
    
    @IBAction func filterByRatting(_ sender: Any) {
        sortingTypesFlag = false
        alphabetFloatingButton.isHidden = true
        priceFloatingButton.isHidden = true
        bestSellerFloatingButton.isHidden = true
        products = products.sorted(by:  {Float($0.templateSuffix ?? "") ?? 0 > Float($1.templateSuffix ?? "") ?? 0})
        searchTableView.reloadData()
    }
    @IBAction func filterByPrice(_ sender: Any) {
        sortingTypesFlag = false
        alphabetFloatingButton.isHidden = true
        priceFloatingButton.isHidden = true
        bestSellerFloatingButton.isHidden = true
        products = products.sorted(by:  {Float($0.variants?[0].price ?? "") ?? 0 < Float($1.variants?[0].price ?? "") ?? 0})
        searchTableView.reloadData()
    }
    
    
    @IBAction func filterAlphabetically(_ sender: Any) {
        sortingTypesFlag = false
        alphabetFloatingButton.isHidden = true
        priceFloatingButton.isHidden = true
        bestSellerFloatingButton.isHidden = true
        products = products.sorted(by:  {Splitter().splitName(text: $0.title ?? "", delimiter: "| ") < Splitter().splitName(text: $1.title ?? "", delimiter: "| ") })
        searchTableView.reloadData()
    }
    
}
