//
//  ShoppingCartViewController.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var shoppingCartTabelView: UITableView!
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var shoppingCartBottomView: UIView!
    
    static var products: [Product] = []
    var allVariants: [Variants] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShoppingCartCellNibFile()
        setupUI()
        prepareTableCount()
    }
    
    func prepareTableCount(){
        for product in ShoppingCartViewController.products {
            for variants in product.variants ?? []{
                allVariants.append(variants)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
   
    }
    
    func setShoppingCartCellNibFile(){
        let nibFile = UINib(nibName: Constants.nibFileName, bundle: nil)
        shoppingCartTabelView.register(nibFile, forCellReuseIdentifier: Constants.cartCellIdentifier)
    }
    
    func setupUI(){
        proceedToCheckoutButton.layer.cornerRadius = 12
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueToOrder(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
        let orderStoryBoard = storyboard.instantiateViewController(withIdentifier: Constants.orderStoryID) as! ReceiptViewController
        orderStoryBoard.modalPresentationStyle = .fullScreen
        orderStoryBoard.products = ShoppingCartViewController.products
        present(orderStoryBoard, animated: true)
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allVariants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cartCellIdentifier, for: indexPath) as! ShoppingCartTableViewCell
        
        for product in ShoppingCartViewController.products{
            if allVariants[indexPath.row].productId == product.id{
                cell.setValues(product: product, variant: allVariants[indexPath.row], viewController: self)
                break
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            
            let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.warning, msg: Constants.removeCartItem, negativeButtonTitle: Constants.cancel, positiveButtonTitle: Constants.ok, positiveHandler: { [weak self] action in
                
                for productIndex in ShoppingCartViewController.products.indices{
                    for variantIndex in ShoppingCartViewController.products[productIndex].variants!.indices{
                        if ShoppingCartViewController.products[productIndex].variants![variantIndex].id == self?.allVariants[indexPath.row].id{
                            ShoppingCartViewController.products[productIndex].variants?.remove(at: variantIndex)
                            break
                        }
                    }
                }
                
                self?.allVariants.remove(at: indexPath.row)
                self?.shoppingCartTabelView.reloadData()
            })
            self.present(alert, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: Constants.productDetailsStoryboardName, bundle: nil)
//        let productDetails = storyboard.instantiateViewController(withIdentifier: Constants.productDetailsStoryboardName) as! ProductDetailsViewController
//        productDetails.product = ShoppingCartViewController.selectedProductList[indexPath.row].product
//        productDetails.modalPresentationStyle = .fullScreen
//        present(productDetails, animated: true)
//    }
}


