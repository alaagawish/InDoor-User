//
//  ShoppingCartTableViewCell.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import UIKit

class ShoppingCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shoppingCartImage: UIImageView!
    @IBOutlet weak var shoppingCartProductNameLabel: UILabel!
    @IBOutlet weak var shoppingCartProductDescriptionLabel: UILabel!
    @IBOutlet weak var shoppingCartPriceLabel: UILabel!
    @IBOutlet weak var shoppingCartProductCountLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var viewController: ShoppingCartViewController?
    var totalAvailableVariantInStock: Int = 0
    var productCount = 1
    var itemInCart: LineItems!
    var generalViewModel = GeneralViewModel(network: Network())
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 8
            frame.size.width -= 2 * 8
            frame.origin.y += 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCartItemValues(lineItem: LineItems, viewController: ShoppingCartViewController){
        print("---------\(lineItem.properties?[0].value)")
        let imageUrl = (lineItem.properties?[0].value?.split(separator: "$")[0])!
        
       print("+++++++++ \(imageUrl)")
        
        self.shoppingCartImage.kf.setImage(with: URL(string: String(imageUrl)),placeholder: UIImage(named: Constants.noImage))
        self.shoppingCartProductNameLabel.text = lineItem.name
        self.shoppingCartProductDescriptionLabel.text = "\(lineItem.vendor ?? "") / \((lineItem.variantTitle)!)"
        self.shoppingCartPriceLabel.text = "\(UserDefault().getCurrencySymbol()) " + String(format: "%.2f", Double(lineItem.price ?? "0.0")! * UserDefault().getCurrencyRate()) + " / item"
        self.shoppingCartProductCountLabel.text = "\((lineItem.quantity)!)"
        productCount = lineItem.quantity!
        if productCount == 1 {
            minusButton.isEnabled = false
        }
        totalAvailableVariantInStock = Int(lineItem.properties?[0].name ?? "1") ?? 1
        if totalAvailableVariantInStock > 3 && productCount < totalAvailableVariantInStock/3 || totalAvailableVariantInStock <= 3 && productCount < totalAvailableVariantInStock {
            
        }else{
            plusButton.isEnabled = false
        }
        
        self.viewController = viewController
        self.itemInCart = lineItem
    }
        
    @IBAction func minusButton(_ sender: Any) {
        
        plusButton.isEnabled = true
        viewController!.cartPrice = Double(viewController!.cartPrice) - Double(productCount) * Double(itemInCart.price!)!
        productCount -= 1
        viewController!.cartPrice = Double(viewController!.cartPrice) + Double(productCount) * Double(itemInCart.price!)!
        shoppingCartProductCountLabel.text = "\(productCount)"
        updateItemsQuantityInShoppingCartList()
        
        if productCount == 1 {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.minCartItem, positiveButtonTitle: Constants.ok)
            viewController?.present(alert, animated: true)
            minusButton.isEnabled = false
        }
    }
    
    @IBAction func plusButton(_ sender: Any) {
        
        minusButton.isEnabled = true
        if totalAvailableVariantInStock > 3 && productCount < totalAvailableVariantInStock/3 || totalAvailableVariantInStock <= 3 && productCount < totalAvailableVariantInStock {
            viewController!.cartPrice = Double(viewController!.cartPrice) - Double(productCount) * Double(itemInCart.price!)!
            productCount += 1
            viewController!.cartPrice = Double(viewController!.cartPrice) + Double(productCount) * Double(itemInCart.price!)!
            shoppingCartProductCountLabel.text = "\(productCount)"
            updateItemsQuantityInShoppingCartList()
            
            if totalAvailableVariantInStock > 3 && productCount < totalAvailableVariantInStock/3 || totalAvailableVariantInStock <= 3 && productCount < totalAvailableVariantInStock {
                
            }else{
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.maxCartItem, positiveButtonTitle: Constants.ok)
                viewController?.present(alert, animated: true)
                plusButton.isEnabled = false
            }
        }
    }
    
    func updateItemsQuantityInShoppingCartList (){
        for (index , item) in CartList.cartItems.enumerated() {
            if item.variantId == itemInCart.variantId {
                CartList.cartItems[index].quantity = productCount
            }
        }
        generalViewModel.putShoppingCartDraftOrder()
        
    }
}
