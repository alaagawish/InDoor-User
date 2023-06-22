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
    static var products: [Product] = []
    var allVariants: [Variants] = []
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShoppingCartCellNibFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allVariants = []
        setupUI()
        prepareTableCount()
        priceView.isHidden = false
        emptyCartImageView.isHidden = true
        shoppingCartTabelView.isHidden = false
        
    }
    
    func prepareTableCount(){
        totalPrice = 0.0
        for product in ShoppingCartViewController.products {
            for variants in product.variants ?? []{
                allVariants.append(variants)
                totalPrice += (Double(variants.price) ?? 0.0) * Double(variants.inventoryQuantity!)
            }
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
        orderStoryBoard.products = ShoppingCartViewController.products
        orderStoryBoard.subtotalPrice = totalPrice
        present(orderStoryBoard, animated: true)
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allVariants.count == 0 {
            priceView.isHidden = true
            emptyCartImageView.isHidden = false
            shoppingCartTabelView.isHidden = true
        }else {
            priceView.isHidden = false
            emptyCartImageView.isHidden = true
            shoppingCartTabelView.isHidden = false
        }
        return allVariants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cartCellIdentifier, for: indexPath) as! ShoppingCartTableViewCell
        
        for product in ShoppingCartViewController.products{
            if allVariants[indexPath.row].productId == product.id{
                cell.setValues(product: product, variant: allVariants[indexPath.row], viewController: self, index:indexPath.row)
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
                
                self?.allVariants = []
                self?.prepareTableCount()
                
                for productIndex in ShoppingCartViewController.products.indices{
                    for variantIndex in ShoppingCartViewController.products[productIndex].variants!.indices{
                        print("+++++++++\(variantIndex)")
                        print("++++++++++\(ShoppingCartViewController.products[productIndex].variants![variantIndex].title)")
                        if ShoppingCartViewController.products[productIndex].variants![variantIndex].id == self?.allVariants[indexPath.row].id{
                            self?.cartPrice -= Double((self?.allVariants[variantIndex].inventoryQuantity!)!) * Double((self?.allVariants[variantIndex].price)!)!
                            ShoppingCartViewController.products[productIndex].variants?.remove(at: variantIndex)
                            var fakeLineItemArr: [LineItems] = []
                            if ShoppingCartViewController.products[productIndex].variants?.count == 0 {
                                ShoppingCartViewController.products.remove(at: productIndex)
                                if ShoppingCartViewController.products.count == 0{
                                    let lineItem = LineItems(price: "20.0", quantity: 1 ,title: "dummy",properties: [Properties(name: "", value: "")])
                                    fakeLineItemArr.append(lineItem)
                                }
                            }
                            self?.generalViewModel.putShippingCartDraftOrder(useConverterMethod: false, lineItems: fakeLineItemArr)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getSpecificProduct(productId: allVariants[indexPath.row].productId!) { [weak self] product in
            let storyboard = UIStoryboard(name: Constants.productDetailsStoryboardName, bundle: nil)
            let productDetails = storyboard.instantiateViewController(withIdentifier: Constants.productDetailsStoryboardName) as! ProductDetailsViewController
            productDetails.product = product
            productDetails.modalPresentationStyle = .fullScreen
            self?.present(productDetails, animated: true)
        }
    }
}


