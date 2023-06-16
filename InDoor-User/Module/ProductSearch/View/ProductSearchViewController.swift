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
   
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    var disposeBag: DisposeBag!
    var productSearchViewModel: ProductSearchViewModel!
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.searchTableView.register(UINib(nibName: Constants.favoritesNibName, bundle: nil), forCellReuseIdentifier: Constants.favoritesCellIdentifier)
        disposeBag = DisposeBag()
        productSearchViewModel = ProductSearchViewModel(networkManager: Network())
        productSearchViewModel.bindResultToViewController = { [weak self] in
            self?.search()
        }
        productSearchViewModel.getItems()
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
        searchTextField.rx.text.subscribe{[weak self] text in
            guard let self = self else {return}
            self.filter(searchText: text!)
        }.disposed(by: disposeBag)
    }
    
    
    func filter(searchText:String) {
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
    
    func setupUI(){
        setupUIView(uiView: searchTextField)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 12
        uiView.layer.borderWidth = 1.0
        uiView.layer.borderColor = UIColor.black.cgColor
        uiView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.favoritesCellHeight
    }
}
