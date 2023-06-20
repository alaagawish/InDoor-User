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
    var productCount = 1
    var productVariant: Variants!
    var orderedProduct: Product!
    var cellIndex:Int!
    
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
    
    func setValues(product: Product, variant: Variants, viewController: ShoppingCartViewController, index: Int){
        self.shoppingCartImage.kf.setImage(with: URL(string: product.image?.src ?? ""),placeholder: UIImage(named: Constants.noImage))
        self.shoppingCartProductNameLabel.text = product.title
        self.shoppingCartProductDescriptionLabel.text = "\(product.vendor ?? "") / \((variant.title)!)"
        self.shoppingCartPriceLabel.text = "\(UserDefault().getCurrencySymbol()) " + String(format: "%.2f", Double(variant.price)! * UserDefault().getCurrencyRate()) + " / item"
        self.shoppingCartProductCountLabel.text = "\((variant.inventoryQuantity)!)"
        self.cellIndex = index
        
        productCount = variant.inventoryQuantity!
        if productCount == 1 {
            minusButton.isEnabled = false
        }
        
        if variant.oldInventoryQuantity! > 3 && productCount < variant.oldInventoryQuantity!/3 || variant.oldInventoryQuantity! <= 3 && productCount < variant.oldInventoryQuantity! {
            
        }else{
            plusButton.isEnabled = false
        }
        
        self.viewController = viewController
        self.productVariant = variant
        self.orderedProduct = product
    }
    
    @IBAction func minusButton(_ sender: Any) {
        
        plusButton.isEnabled = true
        viewController!.cartPrice = Double(viewController!.cartPrice) - Double(productCount) * Double(productVariant.price)!
        productCount -= 1
        viewController!.cartPrice = Double(viewController!.cartPrice) + Double(productCount) * Double(productVariant.price)!
        shoppingCartProductCountLabel.text = "\(productCount)"
        updateInventoryCount()
        
        if productCount == 1 {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.minCartItem, positiveButtonTitle: Constants.ok)
            viewController?.present(alert, animated: true)
            minusButton.isEnabled = false
        }
    }
    
    @IBAction func plusButton(_ sender: Any) {
        
        minusButton.isEnabled = true
        if productVariant.oldInventoryQuantity! > 3 && productCount < productVariant.oldInventoryQuantity!/3 || productVariant.oldInventoryQuantity! <= 3 && productCount < productVariant.oldInventoryQuantity!  {
            viewController!.cartPrice = Double(viewController!.cartPrice) - Double(productCount) * Double(productVariant.price)!
            productCount += 1
            viewController!.cartPrice = Double(viewController!.cartPrice) + Double(productCount) * Double(productVariant.price)!
            shoppingCartProductCountLabel.text = "\(productCount)"
            updateInventoryCount()
            
            if productVariant.oldInventoryQuantity! > 3 && productCount < productVariant.oldInventoryQuantity!/3 || productVariant.oldInventoryQuantity! <= 3 && productCount < productVariant.oldInventoryQuantity! {
                
            }else{
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.maxCartItem, positiveButtonTitle: Constants.ok)
                viewController?.present(alert, animated: true)
                plusButton.isEnabled = false
            }
        }
    }
    
    func updateInventoryCount(){
        for index in ShoppingCartViewController.products.indices {
            for variantsIndex in ShoppingCartViewController.products[index].variants!.indices {
                if  ShoppingCartViewController.products[index].variants![variantsIndex].id == productVariant.id {
                    ShoppingCartViewController.products[index].variants![variantsIndex].inventoryQuantity = productCount
                    viewController?.allVariants = []
                    viewController?.totalPrice = 0.0
                    viewController?.prepareTableCount()
                    
                }
            }
        }
    }
}
