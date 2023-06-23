//
//  ShoppingCartViewController.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var emptyCartImageView: UIImageView!
    @IBOutlet weak var shoppingCartTabelView: UITableView!
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var shoppingCartBottomView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    var generalViewModel: GeneralViewModel = GeneralViewModel(network: Network())
    var viewModel = ShoppingCartViewModel(netWorkingDataSource: Network())
    var cartPrice  = 0.0{
        didSet{
            totalPriceLabel.text = "\(UserDefault().getCurrencySymbol()) " + String(format: "%.2f", cartPrice * UserDefault().getCurrencyRate())
        }
    }
    var tableArr:[LineItems] = []
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShoppingCartCellNibFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        shoppingCartTabelView.reloadData()
        setupUI()
        prepareCartPrice()
        priceView.isHidden = false
        emptyCartImageView.isHidden = true
        shoppingCartTabelView.isHidden = false
        
        tableArr = CartList.cartItems
    }
    
    func prepareCartPrice(){
        totalPrice = 0.0
        for item in CartList.cartItems {
            totalPrice += (Double(item.price!) ?? 0.0) * Double(item.quantity!)
        }
        cartPrice = totalPrice
        shoppingCartTabelView.reloadData()
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
        orderStoryBoard.subtotalPrice = totalPrice
        present(orderStoryBoard, animated: true)
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CartList.cartItems.count == 0 {
            priceView.isHidden = true
            emptyCartImageView.isHidden = false
            shoppingCartTabelView.isHidden = true
        }else {
            priceView.isHidden = false
            emptyCartImageView.isHidden = true
            shoppingCartTabelView.isHidden = false
        }
        return tableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cartCellIdentifier, for: indexPath) as! ShoppingCartTableViewCell
        cell.setCartItemValues(lineItem: tableArr[indexPath.row], viewController: self)
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
                self?.cartPrice -= Double(CartList.cartItems[indexPath.row].price!)! * Double(CartList.cartItems[indexPath.row].quantity!)
                CartList.cartItems.remove(at: indexPath.row)
                self?.tableArr.remove(at: indexPath.row)
                self?.generalViewModel.putShoppingCartDraftOrder()
                self?.shoppingCartTabelView.reloadData()
            })
            self.present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getSpecificProduct(productId: tableArr[indexPath.row].productId!) { [weak self] product in
            let storyboard = UIStoryboard(name: Constants.productDetailsStoryboardName, bundle: nil)
            let productDetails = storyboard.instantiateViewController(withIdentifier: Constants.productDetailsStoryboardName) as! ProductDetailsViewController
            productDetails.product = product
            productDetails.modalPresentationStyle = .fullScreen
            self?.present(productDetails, animated: true)
        }
    }
}


