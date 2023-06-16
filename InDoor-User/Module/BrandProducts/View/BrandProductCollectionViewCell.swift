//
//  BrandProductCollectionViewCell.swift
//  InDoor-User
//
//  Created by Alaa on 07/06/2023.
//

import UIKit

class BrandProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var currencySymbol: UILabel!
    var view: String = ""
    var viewController: UIViewController?
    var product:Product!
    var categoryViewController: CategoryViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
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
    func setValues(product:Product, isFav: Bool, viewController: UIViewController, view: String ) {
        
        if UserDefault().getCustomerId() == -1 {
            favouriteButton.isHidden = true
        }else {
            favouriteButton.isHidden = false
        }
        if view == Constants.brand {
            self.view = view
            self.viewController = viewController as! BrandViewController
        }else {
            self.view = view
            self.viewController = viewController as! CategoryViewController
        }
        self.product = product
        self.productTitle.text = Splitter().splitName(text: product.title ?? "", delimiter: "|")
        self.productImage.kf.setImage(with: URL(string: product.image?.src ?? ""),
                                      placeholder: UIImage(named: Constants.noImage))
        self.currencySymbol.text = UserDefault().getCurrencySymbol()
        if isFav {
            self.favouriteButton.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
        } else {
            self.favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
        }
        
        if product.variants?.count ?? 0 > 0{
            
            self.price.text = String(format: "%.2f", Double(product.variants![0].price)! *  UserDefault().getCurrencyRate())
        }
    }

    @IBAction func checkFavouriteProduct(_ sender: Any) {
        
        if favouriteButton.currentImage == UIImage(systemName: Constants.heart) {
            let localProduct = LocalProduct(id: product.id, title: product.title ?? "", status: product.status ?? "", price: product.variants?[0].price ?? "", image: product.image?.src ?? "")
            if self.view == Constants.brand {
                ( viewController as! BrandViewController).favoritesViewModel.addProduct(product: localProduct)
            }else {
                ( viewController as! CategoryViewController).favoritesViewModel.addProduct(product: localProduct)
            }
            favouriteButton.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
            
        } else {
            if self.view == Constants.brand {
                let retrievedProduct = ( self.viewController as! BrandViewController).favoritesViewModel.getProduct(productId: self.product.id )
                
                let alert = Alert().showRemoveProductFromFavoritesAlert(title: Constants.removeAlertTitle, msg: Constants.removeAlertMessage) { [weak self] action in
                    ( self?.viewController as! BrandViewController).favoritesViewModel.removeProduct(product: retrievedProduct)
                    self?.favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
                }
                viewController?.present(alert, animated: true, completion: nil)
            }else {
                let retrievedProduct = ( self.viewController as! CategoryViewController).favoritesViewModel.getProduct(productId: self.product.id )
                
                let alert = Alert().showRemoveProductFromFavoritesAlert(title: Constants.removeAlertTitle, msg: Constants.removeAlertMessage) { [weak self] action in
                    ( self?.viewController as! CategoryViewController).favoritesViewModel.removeProduct(product: retrievedProduct)
                    self?.favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
                }
                viewController?.present(alert, animated: true, completion: nil)
            }
        }
             
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            var frame = newFrame
            frame.origin.x += 8
            frame.origin.y += 8
            frame.size.width -= 2 * 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
    }
    
}
