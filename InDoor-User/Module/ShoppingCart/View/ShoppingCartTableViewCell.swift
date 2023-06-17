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
    
    var viewController: UIViewController?
    var productCount = 1
    var productVariant: Variants!
    var orderedProduct: Product!
    
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
        
        // Configure the view for the selected state
    }
    
    func setValues(product: Product, variant: Variants, viewController: UIViewController){
        self.shoppingCartImage.kf.setImage(with: URL(string: product.image?.src ?? ""),placeholder: UIImage(named: Constants.noImage))
        self.shoppingCartProductNameLabel.text = product.title
        self.shoppingCartProductDescriptionLabel.text = "\(product.vendor ?? "") / \((variant.title)!)"
        self.shoppingCartPriceLabel.text = "\(UserDefault().getCurrencySymbol()) \(variant.price)"
        self.shoppingCartProductCountLabel.text = "\((variant.inventoryQuantity)!)"
        
        productCount = variant.inventoryQuantity!
        if productCount == 1 {
            minusButton.isEnabled = false
        }
        
        self.viewController = viewController
        self.productVariant = variant
        self.orderedProduct = product
    }
    
    @IBAction func minusButton(_ sender: Any) {
        
        productCount = Int(shoppingCartProductCountLabel.text!)!
        plusButton.isEnabled = true
        if productCount == 1 {
            minusButton.isEnabled = false
        }else{
            productCount -= 1
            shoppingCartProductCountLabel.text = "\(productCount)"
            
            if productCount == 1 {
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.minCartItem, positiveButtonTitle: Constants.ok)
                viewController?.present(alert, animated: true)
                minusButton.isEnabled = false
            }
        }
        
        updateInventoryCount()
    }
    
    @IBAction func plusButton(_ sender: Any) {
        
        productCount = Int(shoppingCartProductCountLabel.text!)!
        minusButton.isEnabled = true
        if productVariant.oldInventoryQuantity! > 3 && productCount < productVariant.oldInventoryQuantity!/3 || productVariant.oldInventoryQuantity! <= 3 && productCount < productVariant.oldInventoryQuantity!  {
            
            productCount += 1
            shoppingCartProductCountLabel.text = "\(productCount)"
            
            if productVariant.oldInventoryQuantity! > 3 && productCount < productVariant.oldInventoryQuantity!/3 || productVariant.oldInventoryQuantity! <= 3 && productCount < productVariant.oldInventoryQuantity! {
                
            }else{
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.maxCartItem, positiveButtonTitle: Constants.ok)
                viewController?.present(alert, animated: true)
                plusButton.isEnabled = false
            }
        }
        
        updateInventoryCount()
    }
    
    func updateInventoryCount(){
        for index in ShoppingCartViewController.products.indices {
            for variantsIndex in ShoppingCartViewController.products[index].variants!.indices {
                if  ShoppingCartViewController.products[index].variants![variantsIndex].id == productVariant.id {
                    ShoppingCartViewController.products[index].variants![variantsIndex].inventoryQuantity = productCount
                    productVariant.inventoryQuantity = productCount
                }
            }
        }
    }
}
